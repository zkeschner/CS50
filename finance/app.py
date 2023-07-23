import os

from cs50 import SQL
from flask import Flask, flash, redirect, render_template, request, session
from flask_session import Session
from tempfile import mkdtemp
from werkzeug.security import check_password_hash, generate_password_hash
import datetime

from helpers import apology, login_required, lookup, usd
# export API_KEY=pk_4149da89d594401a82c649af2b4cb7ec

# Configure application
app = Flask(__name__)

# Ensure templates are auto-reloaded
app.config["TEMPLATES_AUTO_RELOAD"] = True

# Custom filter
app.jinja_env.filters["usd"] = usd

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///finance.db")

# Make sure API key is set
if not os.environ.get("API_KEY"):
    raise RuntimeError("API_KEY not set")


@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


@app.route("/")
@login_required
def index():
    """Show portfolio of stocks"""
    user_id = session["user_id"]
    cash1 = db.execute("select cash from users where id = ?", user_id)
    cash = cash1[0]["cash"]
    sharesdict = db.execute("select shares from purchases where user_id = ?", user_id)
    stockdict = db.execute("select stock from purchases where user_id = ?", user_id)
    list1 = []

    for i in range(len(stockdict)):
        list1.append(lookup(stockdict[i]["Stock"]))

    total = 0
    for x in range(len(list1)):
        total += (sharesdict[x]["Shares"] * list1[x]["price"])
    total_assets = float(cash) + float(total)
    cash = usd(cash)
    total_assets = usd(total_assets)
    dictionary = db.execute("select stock, shares from purchases where user_id = ?", user_id)
    for b in range(len(dictionary)):
        dictionary[b]["price"] = usd(lookup(dictionary[b]["Stock"])["price"])
        dictionary[b]["total value"] = usd(lookup(dictionary[b]["Stock"])["price"] * dictionary[b]["Shares"])
    return render_template("index.html", cash=cash, totals=total_assets, dictionary=dictionary)


@app.route("/buy", methods=["GET", "POST"])
@login_required
def buy():
    """Buy shares of stock"""
    if request.method == "GET":
        return render_template("buy.html")
    else:
        symbol = request.form.get("symbol")
        try:
            shares = int((request.form.get("shares")))
        except ValueError:
            return apology("Must Be A Positive Whole Number")
        look = lookup(symbol.upper())
        if look == None:
            return apology("Does Not Exist")
        if shares <= 0:
            return apology("Shares Must be Greater than 0")

        price = look["price"]
        user_id = session["user_id"]
        dict_cash = db.execute("select cash from users where id = ?", user_id)
        cash = dict_cash[0]["cash"]
        buy = "Buy"
        date = datetime.datetime.now()
        if cash >= (shares * price):
            new_cash = cash - (shares * price)
            db.execute("update users set cash = ? where id = ?", new_cash, user_id)
            db.execute("insert into Purchases (stock, user_id, price, date, shares) values (?, ?, ?, ?, ?)",
                       symbol, user_id, price, date, shares)
            flash("Transaction Confirmed")
            db.execute("insert into history (user_id, stock, price, date, shares, type) values (?,?,?,?,?, ?)",
                       user_id, symbol, price, date, shares, buy)
            return redirect("/")
        else:
            return apology("Insufficient Funds")


@app.route("/addcash", methods=["GET", "POST"])
@login_required
def addcash():
    if request.method == "GET":
        return render_template("cash.html")
    else:
        user_id = session["user_id"]
        amount = int(request.form.get("cash"))
        dict_cash = db.execute("select cash from users where id = ?", user_id)
        cash = int(dict_cash[0]["cash"])
        new_cash = cash + amount
        db.execute("update users set cash = ? where id = ?", new_cash, user_id)
        return redirect("/")


@app.route("/history")
@login_required
def history():
    """Show history of transactions"""
    user_id = session["user_id"]
    database = db.execute("select * from history where user_id = ?", user_id)
    return render_template("history.html", database=database)


@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in"""

    # Forget any user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":

        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 403)

        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 403)

        # Query database for username
        rows = db.execute("SELECT * FROM users WHERE username = ?", request.form.get("username"))

        # Ensure username exists and password is correct
        if len(rows) != 1 or not check_password_hash(rows[0]["hash"], request.form.get("password")):
            return apology("invalid username and/or password", 403)

        # Remember which user has logged in
        session["user_id"] = rows[0]["id"]

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")


@app.route("/logout")
def logout():
    """Log user out"""

    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")


@app.route("/quote", methods=["GET", "POST"])
@login_required
def quote():
    """Get stock quote."""
    if request.method == "GET":
        return render_template("quote.html")
    else:
        symbol = request.form.get("symbol")
        quote = lookup(symbol)
        if quote == None:
            return apology("Does Not Exist")
        return render_template("quoted.html", price=usd(quote["price"]), name=quote["name"])


@app.route("/register", methods=["GET", "POST"])
def register():
    """Register user"""
    if request.method == "POST":
        name = request.form.get("username")
        password = request.form.get("password")
        confirm = request.form.get("confirmation")
        if not name or not password or not confirm:
            return apology("Please enter username and password")
        if confirm != password:
            return apology("Password's Must Match")
        passhash = generate_password_hash(password)
        try:
            db.execute("insert into users(username, hash) values (?, ?)", name, passhash)
        except:
            return apology("Username already taken")

    else:
        return render_template("register.html")
    return redirect("/")


@app.route("/sell", methods=["GET", "POST"])
@login_required
def sell():
    """Sell shares of stock"""
    if request.method == "GET":
        user_id = session["user_id"]
        symbols = db.execute("select Stock from purchases where user_id = ?", user_id)
        symlist = []
        for m in range(len(symbols)):
            symlist.append(symbols[m]["Stock"])
        return render_template("sell.html", quotes=symlist)
    else:
        symbol = request.form.get("symbol")
        shares = int(request.form.get("shares"))
        look = lookup(symbol.upper())
        price = look["price"]
        if look == None:
            return apology("Does Not Exist")
        if shares <= 0:
            return apology("Shares Must be Greater than 0")
        user_id = session["user_id"]
        dict_cash = db.execute("select cash from users where id = ?", user_id)
        cash = dict_cash[0]["cash"]
        check = db.execute("select sum(shares) as shares from purchases where stock = ? and user_id = ?", symbol, user_id)
        sharescheck = check[0]["shares"]
        date = datetime.datetime.now()
        sell = "Sell"
        if sharescheck < shares:
            return apology("Not enough shares")
        else:
            flash("Transaction Confirmed")
        new_cash = cash + (shares * price)
        db.execute("update users set cash = ? where id = ?", new_cash, user_id)
        db.execute("update Purchases set shares = ? where stock = ? and user_id = ?", (sharescheck - shares), symbol, user_id)
        db.execute("insert into history (user_id, stock, price, date, shares, type) values (?,?,?,?,?,?)",
                   user_id, symbol, price, date, shares, sell)
        db.execute("delete from purchases where shares = 0 and user_id = ?", user_id)
        return redirect("/")

