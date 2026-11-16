# Tutorial2

Source: `theory/Tutorial2.pdf` (101 pages)

> Automatic text extraction (pdftotext). Formulas are kept as plain text and may be
> flattened (fractions, sums, subscripts); check the PDF for anything that looks odd.


## Page 1

Tutorial 2
Shuxiao Zhou 12 October 2026

## Page 2

Today’s Agenda
Duration and Convexity The yield curve and forward interest rates The yield curve and the business cycle Additional stylized facts of Bond yield curve Factors determining the term structure of interest rates
2

## Page 3

Elementary facts about Bonds

## Page 4

What is the Bond?
Let t1, t2, · · · , tn ≡ T be a sequence of dates. A bond promises to pay fixed coupons Ct over this sequence of dates and the principal of $1 at date T .
3

## Page 5

Bond Price, Zeros
The price of a bond as of time t: B(t, T ), where t ≤ t1. The price of a zero coupon bond (in short, a ”zero”) pays the principal of $1 at date T as P(t, T ). To simplify notation, we let B(T ) ≡ B(0, T ) and P(T ) ≡ P(0, T ). (When we need to emphasize the time dependence, we shall keep on using the notation B(t, T ) and P(t, T ).
4

## Page 6

Spot rate

The spot rate for some maturity date T is the yield on the zero maturing at T , denoted as r (T ).r (T ) is the solution to the following equation,

1 P(T ) = [1 + r (T )]T

That

is,

1

+

r (T )

=

P

(T

)−

1 T

.

5

## Page 7

Semi-annual compounding and Continuous compounding

With semi-annual compounding (which is relevant in the US), we have that

1

P(T )

=

[︂ 1

+

r(T ) ]︂2T
2

.

In general, we have that if the interest is compounded m times in a year, at the annual rate r , then, investing for T years gives
[︂ r ]︂mT 1+
m

6

## Page 8

Continuous compounding

Recall the math equation of e:

(︃ 1 )︃n

e = lim 1 +

n→∞

n

Continuous compounding is obtained by letting m → ∞ in the previous expression, which leaves erT .
Therefore, the continuously compounded spot rate is obtained as 1
r (T ) = − log P(T ). T

7

## Page 9

Bonds in the absence of arbitrage opportunities
B(T ) = Ct1P (t1) + · · · + (Ctn + 1) P (tn)
8

## Page 10

Yield to maturity

The yield to maturity yˆ (YTM, henceforth) on a bond is its rate of return.

It is the discount rate that would equate the present value of the stream of payoffs

with its market price,

B (T

)

=

n
∑︂

(1

Cti + yˆ)ti

+

1 (1 + yˆ)T .

i =1

This formula differs from the price formula

B (T

)

=

n
∑︂
i =1

[1

Cti + r (ti

)]ti

+

1 [1 + r (T )]T

,

9

## Page 11

Yield to maturity
The first equation uses the same discount rate yˆ to discount the future payements. Clearly, for zeros we have that spot rates coincide with YTM, i.e. yˆ = r (t)
10

## Page 12

Duration and convexity

## Page 13

Duration and Convexity
• Bond • Duration • Convexity
11

## Page 14

Duration and Convexity: Notation and Basic concepts
• B(yˆ; T ) = B(T ): Bond Price with a maturity of T.
• yˆ: The yield to maturity (YTM) on a bond is its rate of return
(Bond Return).
• Cti : Coupons (no nominal value).
The bond pays a series of cash flows {Cti }i ∈ 1 . . . n at times {ti }i ∈ 1 . . . n. (Cash Flow)
• Tips: If you do not fully understand the Bond, think about the Stock price, Stock return and Dividend.
12

## Page 15

Relation among Bond Price, YTM and Coupon

• Annual compounding:

B (yˆ;

T

)

=

B (T

)

=

n
∑︂

(1

Cti + yˆ)ti

+

1 (1 + yˆ)T

i =1

• Continuous compounding:

Bcont

(yˆcont ; T ) = Bcont

(yˆcont

)

=

n
∑︂
i =1

(exp

Cti (yˆcont

))ti

+

1 (exp (yˆcont ))T

• Relation: we equate the present value of the cash flow stream (coupon) to the observable market price of the bond (coupon bearing or zero)

and solve for the interest rate (YTM)/ (Bond return).
13

## Page 16

Why should we care about the Bond’s YTM? (Bond return)

## Page 17

YTM as a description of market conditions
• Why should we care about the Bond’s YTM? (or Stock return?)
• What is the risk of holding a bond?
• The risk of going long a default-free bond is:
the future bond price (future spot rate/ future short term interest rate) is uncertain, due to the possibility that the spot interest rates could change in the future
• Default-free bonds: the bonds with no default risk, such as U.S. government bonds.
• The risk of a bond is related to the changes in the required bond return, or the 14

## Page 18

YTM as a description of market conditions
• How strongly the (Bond) price reacts to potential changes in YTM: (Bond) price sensitivity.
• Of course, YTM of the bonds differ across the maturities and coupon rates
15

## Page 19

Duration: Bond’s price sensitivity to YTM

## Page 20

Duration: bond’s price sensitivity to YTM/(interest rate) changes

• Define a measure of risk of the bond based on the sensitivity of the bond price with respect to changes in yˆ.

• Mathematically, this sensitivity is the first partial of the ”bond-pricing” formula B(y ; T ) with respect to y ,

1 By (y ; T ) = − 1 + y

[︄ n ∑︂

ti · Cti

(1 + y )ti

+

]︄ T ·1
(1 + y )T

i =1

where

the

subscript

denotes

a

partial

derivative,

i.e.

By (y ; T )

=

∂ ∂y

B

(y

;

T

).

• Graphically, this sensitivity measure By (y ; T ) is the tangent to the price-yield relation
16

## Page 21

Two types of Duration
• Duration can measure the sensitivity of a bond’s price to changes in YTM/interest rates.
• Modified Duration • Macaulay Duration
17

## Page 22

Modified Duration
• Modified Duration: percentage change of the bond price corresponding to a small change in YTM. (SEMIELASTICITY)
• it helps investors understand how much a bond’s price will rise or fall if the YTM rises or falls by 1%.
18

## Page 23

Macaulay Duration
• Duration can also measure how long it takes for an investor to be repaid the bond’s price by the bond’s total cash flows.
• Macaulay Duration: weighted average time until all the bond’s cash flows are paid. • is a measure of how far in the future the bond pays off
19

## Page 24

Modified duration: formula
• Precentage change of the bond price per unit change in YTM:
• Modified duration is denoted as D
20

## Page 25

Macaulay duration: formula
• Weighted average lifetime of the bond’s cash flows
• Macaulay duration is denoted as DMac
21

## Page 26

Tips for Duration
• Relationship between Modified duration and Macaulay duration D ≡ −By = DMac B 1+y
• For ”Zeros”, a T-year ZCB,
DMac = T D ≡ −By = DMac = T
B 1+y 1+y
• Zeros: A zero-coupon bond does not pay interest but instead trades at a deep discount, rendering a profit at maturity, when the bond is redeemed for its full face value.
22

## Page 27

Duration for continuously compounded rates

• Macaulay duration does not involve the idea of interest rates. Duration as sensitivity with respect to ycont

• It is possible to show that

Modified duration

=

∂ ∂ ycont

B

=

Macaulay duration

B

• Takeaway:

if I work with continuously compounded rates, then the average lifetime of the cash flows and the sensitivity of the price to the YTM boil down to the same quantity.
23

## Page 28

Convexity: Second order partial derivative

## Page 29

Convexity

• Convexity measures how the sensitivity, By , changes with y .
Mathematically, convexity is related to the second partial of the bond price with respect to y , Byy

• Formally, convexity is defined as,

C ≡ Byy B

24

## Page 30

Why we should pay special attention to Duration and Convexity?

## Page 31

Duration-Convexity approximation for relative changes of bond price

∆B ≈ - Modified Duration × (y − yˆ) + 1 × Convexity × (y − yˆ)2

B

2

Proof:

Use

Taylor

expansion

to

expand

f (y )

around

the

yˆ

(f (y )

=

B(y )−B B (yˆ)

(yˆ)

)

B(y ) − B(yˆ)

=

B(yˆ) − B(yˆ)

+

B ′ (yˆ) (y

− yˆ) +

1

B ′′ (yˆ) (y

− yˆ)2

≈

B (yˆ)

B (yˆ)

B (yˆ)

2 B(yˆ)

=

B ′ (yˆ) (y

− yˆ) +

1

B ′′ (yˆ) (y

− yˆ)2

=

B (yˆ)

2 B(yˆ)

= − Modified Duration × (y − yˆ) + 1 × Convexity × (y − yˆ)2 2

25

## Page 32

Duration-Convexity approximation
• Duration-convexity approximation is a more precise one in a neighborhood of yˆ. • Duration-convexity approximation is more optimistic. • Caveat: In case of huge upward movements in y , the approximation becomes very
poor
26

## Page 33

Introduction to Asset-liability management

## Page 34

Asset-liability management
• Most of the commercial banks and pension funds: major division that analyses how closely the assets match liabilities.
• The goal: make sure that we can meet the liabilities even if the market conditions change.
• Another formulation: market value of the assets changes in the same way as the market value of the liabilities.
27

## Page 35

Asset-liability management: Example
• In 30 years from now, a pension fund is due to deliver $100, 000 to some future retiree.
• The following Asset-Liability structure at the beginning • L: $100000 in 30 years: MV = 100, 000 · (1 + 4%)−30 = 30, 832, • A: Cash or short-term securities: 30,832 , • Net wealth: 0.
28

## Page 36

Asset-liability management: Example
• Case of a sudden increase in the interest rates • L: $100000 in 30 years: MV = 100, 000 · (1 + 5%)−30 = 23, 138, • A: Cash or short-term securities: 30,832 , • Net wealth: 7,694 .
29

## Page 37

Asset-liability management: Example
• Case of a sudden decrease in the interest rates • L: $100000 in 30 years: MV = 100, 000 · (1 + 3%)−30 = 41, 199, • A: Cash or short-term securities: 30,832 , • Net wealth: −10, 367.
30

## Page 38

Asset-liability management: Example
• So a drop in the yield curve results in a loss for the pension fund: • when interest rates go down, the pension fund faces a challenging situation as it has to honour its obligations in 30 years, but the financial market “yields less” than one week ago.
• Another perspective: if the interest rates drop it becomes impossible to invest cash profitably enough to meet the liabilities.
• Conclusion: the PF may become unable to settle its liabilities.
31

## Page 39

Asset-liability management: General Framework

## Page 40

Asset-liability management: General Framework
• Both assets and liabilities can be thought of positions in a long-short (Buy-Sell) portfolio.
• Assets are positive (+) positions while liabilities are negative (-) positions.
• Current value of the portfolio (a portfolio of two bonds with different durations) can be written as: V = B1 (yˆ1) θ1 + B2 (yˆ2) θ2
• where B1 (yˆ1) and B2 (yˆ2) are the market value of the bonds, yˆ1 and yˆ2 are the YTM on the bonds and, finally, θ1 and θ2 are the quantities of bonds in the portfolio.
32

## Page 41

Asset-liability management: General Framework
• Consider a small change in the two YTM yˆ1 and yˆ2. Changes in portfolio value are as follows: dV = − [D (yˆ1) B1 (yˆ1) θ1d yˆ1 + D (yˆ2) B2 (yˆ2) θ2d yˆ2]
• Recall that D (yˆ1) and D (yˆ2) are Modified Durations. • The question is: How should we choose θ1 and θ2 so as to make the value of the
portfolio remain constant after a change in yˆ1 and yˆ2 ?
33

## Page 42

Asset-liability management: General Framework

• To simplify the question, consider a parallel shift in the term structure of interest rates.

In this case, dyˆ1 = dyˆ2.
• The portfolio is said to be immunized if its value V does not change as yˆ1 and yˆ2 change,

i.e. dV = 0,

which is true when,

θ1

=

−

D D

(yˆ2) (yˆ1)

B2 B1

(yˆ2) (yˆ1)

θ2

34

## Page 43

Asset-liability management: General Framework

• Or rearrange,

θ1

=

−θ2

·

B2(yˆ2) B1(yˆ1)

· ·

Mod-duration Mod-duration

(B2) (B1)

• Interpretation:

holding a bond with some duration, say we hold θ2 units of the second bond.

Given these holdings, sell another bond θ1 units, possibly with a lower duration, to hedge against movements in the price of the bond we hold.

35

## Page 44

Barbell and bullet hedges

## Page 45

Barbell and bullet hedges
• Replicating a bullet liability with 2 bullet asset (barbell) • ”Barbell” hedging is a way to hedge some liability (a ”bullet”) with duration D2
through two assets with durations D1 and D3, where D1 < D2 < D3
36

## Page 46

Replicating a bullet liability with 2 bullet asset (barbell)
• Three ”zeros” are available for trading, with maturities equal to 1 year (1st D1) 5 years (2nd D2) 10 years (3rd D3)
• Goal: hedge against movements in the price of the 5Y zero (2nd) with a portfolio consisting of (i) one 1Y zero (1st) and (ii) the 10Y zero (3rd).
37

## Page 47

Replicating a bullet liability with 2 bullet asset (barbell)
• Current term structure (yield curve/ interest rate) is flat at 5% • For simplification, consider parallel shifts in the term-structure of interest rates.
38

## Page 48

Replicating a bullet liability with 2 bullet asset (barbell)
• Let’s call the investment in the 1-year ZCB (1st) θ1, investment in 10-year ZCB (3rd) θ3
• The market value of the portfolio equals the market price of the 5-year ZCB ((2nd)): B2 (yˆ2) = B1 (yˆ1) θ1 + B3 (yˆ3) θ3
• Replicating:
the local risk of the portfolio equals the local risk of the 5Y zero, (∂B2 (yˆ2) /∂yˆ2 = −D (yˆ2))B2 (yˆ2)
D (yˆ2) B2 (yˆ2) = D (yˆ1) B1 (yˆ1) θ1 + D (yˆ3) B3 (yˆ3) θ3
39

## Page 49

Replicating a bullet liability with 2 bullet asset (barbell)

• Two equations and two unknown variables, θ1 and θ3,

θ1

=

D (yˆ3) − D (yˆ2) D (yˆ3) − D (yˆ1)

B2 (yˆ2) , B1 (yˆ1)

θ3

=

D (yˆ2) − D (yˆ1) D (yˆ3) − D (yˆ1)

B2 (yˆ2) B3 (yˆ3)

9.5238 − 4.7619 0.78353

4.7619 − 0.95238 0.78353

θ1 =

= 0.45706, θ3 =

= 0.56724

9.5238 − 0.95238 0.95238

9.5238 − 0.95238 0.61391

• Recall : • For ”Zeros”,for example, a T-year ZCB,
DMac = T D ≡ −By = DMac = T
B 1+y 1+y

40

## Page 50

Replicating a bullet liability with 2 bullet asset (barbell)

• Calculation details: • For example, How to compute B1 (yˆ1) and D (yˆ1)

• At 5% Interest rate, 1-year ZCB (1st):

•

B1 (yˆ1) =

1 1+yˆ1

=

1 1+0.05

= 0.95238,

•

D (yˆ1) =

DMac (yˆ1 ) 1+yˆ1

=

1 1+0.05

=

0.95238

• At 5% Interest rate, 5-year ZCB (2nd):

•

B2 (yˆ2) =

1 (1+yˆ2 )5

=

1 (1+0.05)5

= 0.78353

•

D (yˆ2) =

DMac (yˆ2 ) 1+yˆ2

=

5 1+0.05

=

4.7619

• ···
41

## Page 51

Physical analogy
• What is barbell?
• The bullet liability is the center of mass (5-year ZCB (2nd)). • The bonds that are supposed to replicate the liability are the weight at the ends of
the bar. • 1-year ZCB (1st) • 10-year ZCB (3rd)
• Generally, the barbell is uneven: θ1 ≠ θ2 • The center of mass is closer to the bigger weight
42

## Page 52

Barbell-bullet
43

## Page 53

Barbell-bullet
• Under the assumption: parallel shifts in the term-structure of interest rates
• Barbell portfolio is more convex than the bullet.
• Barbell portfolio has the same mod.duration as the bullet.
• “Barbell-bet” is “self-financed.” By construction, the value of the bullet we sell equals the value of the barbell portfolio.
• The barbell portfolio is clearly NOT an arbitrage opportunity. We relies on the assumption of a parallel shift in the term structure of interest rates.
44

## Page 54

Parallel shifts and non-parallel shifts
• Previously we heavily rely on the assumptions: • Current term structure (yield curve/ interest rate) is flat at 5%
• yˆ1 = yˆ2 = yˆ3 = 5% • Parallel Shifts
• d yˆ1 = d yˆ2 = d yˆ3
• The next table considers the case of non-parallel shifts in the term-structure. We assume that the initial term-structure is not flat.
• Consider two scenarios: • A ”twist” in the term-structure, i.e. long-term rates lower than short-term rates. • A ”steepening” of the term-structure.
45

## Page 55

Non-parallel shifts cases
46

## Page 56

Summary
• Duration hedging is a useful tool, although it has some limitations • It is only a first-order approximation to the price of bond. A conventional bond is
typically strictly convex in the YTM. Therefore, for large changes in the YTM, we should update the duration-based hedging ratios. • Re-adjustments are in order anyway, since fixed income securities have duration that decreases over time.
47

## Page 57

The yield curve and forward interest rates

## Page 58

Zero Coupon bond prices

## Page 59

A representation of Zero Coupon bond prices

P(τ, T ) : price at τ of a zero coupon bond expiring at T

L : discretely compounded interest rate for the time interval T , 1
P(τ, T ) = 1 + (T − τ )L(τ, T )

The (continuosly compounded) short-term rate process r is

rτ ≡ lim L(τ, T ).
T ↓τ

Under conditions, there is no arbitrage if and only if

P (τ ,

T

)

=

Eτ

(︂ e−

´T
τ

rs ds

)︂

,

where Eτ (·) is expectation under Q conditional on information at time τ
48

## Page 60

Fixed Coupon bond prices

## Page 61

A representation of Fixed Coupon bond prices
Given a set of dates {Ti }ni=0, consider a fixed coupon bond that pays off a coupon stream ci at Ti , i = 1, · · · , n, and $1 at Tn; Under conditions, its value is
n
∑︂ Pfcb (t, Tn) = P (t, Tn) + ci P (t, Ti )
i =1
49

## Page 62

The yield curve

## Page 63

Yiled Curve
What is a yield curve? Relationship between Yield and Maturity (Long term yield v.s. Short term yield) Yield curve = Term structure of interest rates
50

## Page 64

Yield Curve: Formal definition

The yield curve at time t for maturity at T is defined as the curve (for fixed t )

T ↦−→ L(t, T )

where the ”spot rate” L(t, T ) is

1

L(t, T ) ≡ −

ln P(t, T )

T −t

51

## Page 65

Forward rates

## Page 66

Forward rate agreement
In a forward rate agreement (FRA, henceforth) one party shall borrow from a counterparty in the future Buyer: Borrower Seller: Lender Forward contracts have an initial value of $0 because no money changes hands with the initial agreement, meaning no value can be attributed to the contract. Forward rates are such that the value of a FRA equal to zero at origination
52

## Page 67

Forward Rates: Formal Definition

F (t, T , S) : Forward rates at t, regarding a future time-interval [T , S]

Possible to show that

P(t, T ) = 1 + (S − T )F (t, T , S).
P(t, S)

Clearly we have that

F (T , T , S) = L(T , S)

53

## Page 68

Forward Rates: Formal Definition

We can use absence of arbitrage to express F (t, T , S) in terms of bond prices, P(t, T ) = 1 + (S − T )F (t, T , S). P(t, S)
An investor in a zero from time t to time S is one who simultaneously makes:

(i) a spot loan from t to T , and (ii) a forward loan from T to S.

In the absence of arbitrage, it must be the case that,

[1 + r (t, S)]S−t = [1 + r (t, T )]T −t × [1 + (S − T )F (t, T , S)] ,

⏞ ⏟⏟ ⏞ ⏞ ⏟⏟ ⏞ ⏞

⏟⏟

⏞

zero loan

spot loan

forward loan

54

## Page 69

“Instantaneous” forward rate: A second representation of bond prices

## Page 70

“Instantaneous” forward rate: A second representation of bond prices

Rearrange terms in Equation, P(t, T ) = 1 + (S − T )F (t, T , S). P(t, S)

We obtain,

F (t, T , S) = − P(t, S) − P(t, T ) (S − T )P(t, S)

The instantaneous forward rate f (t, T ) is defined as

∂ ln P(t, T )

f (t, T ) ≡ lim F (t, T , S) = −

S ↓T

∂T

It’s the marginal rate of return from committing a bond investment for an additional instant

55

## Page 71

“Instantaneous” forward rate: A second representation of bond prices

Goal: We may express bond prices in terms of “instantaneous” forward rates.

Integrate

Equation

f (t, ℓ)

=

−

∂

ln

P (t ∂ℓ

,ℓ)

against

maturity

dates

ℓ,

use P(t, t) = 1, and obtain:

P (t ,

T

)

=

e−

´T
t

f

(t ,ℓ)d ℓ .

This Equation suggests that we may model the yield curve by emphasizing the dynamics of forward rates

Compare it with page 5, the last equation
56

## Page 72

The yield curve and the business cycle

## Page 73

Expectation Hypothesis

## Page 74

Expectation Hypothesis
(Current) Forward rates equal to expected future short-term rates
57

## Page 75

Expectation Hypothesis
• Consider the following two strategies: • Strategy 1: invest in a two-year bond with an yield of 2% • Strategy 2: invest in a 1-year bond with yield 1% and, after one year, reinvest the proceedings in another 1-year bond
• Q: which strategy will deliver the highest return?
• A: it depends on the after-1-year future short-term rate! If this turns out to be lower than 3% (︁1.022/1.01 − 1)︁, then the first strategy would have been preferable.
• Main point: we don’t know today what the future short-term (1-year) rate will be after one year
58

## Page 76

Expectation Hypothesis
• The Expectation Hypothesis states that the expected (at time time 0) return from the two strategies is the same!
• If long-term yields are higher than short-term, this simply reflects the expectations that the short-term rate will increase, thus offsetting the gain in investing in strategy 1
• (Current) Forward rates equal expected future short-term rates
• Put alternatively, the portfolio of a long position in strategy 1 and a short position in strategy 2 will yield an expected return of 0.
High yield does not mean higher return...On average...Statistically
59

## Page 77

The yield curve and the business cycle

## Page 78

The yield curve and the business cycle
Yield curve: Relationship between Yield and Maturity (Long term yield v.s. Short term yield) Yield curves on average slopes up
60

## Page 79

The yield curve and the business cycle
Why Yield curves on average slopes up? long-term yields are larger than short-term yields What are the business cycle properties of the yield curve?
61

## Page 80

Why Yield curves on average slopes up?
Two reasons for slopes up:
• Reason 1: Interest rates are expected to increase. Consider the following two strategies: 1. invest in a two-year bond with an yield of 2% 2. invest in a 1-year bond with yield 1% and, after one year, reinvest the proceedings in another 1-year bond
• Reason 2: Investors are risk averse. It is compensation for more risks: to compensate the holders of longer bonds for the risk that they lose money when they sell the bond at the end of their preferred holding period.
62

## Page 81

Business cycle properties of the yield curve
However, yield curve may invert—Slope down. long-term yields are smaller than short-term yields Why we observe a yield curve inversion? Check Professor’s Lecture
63

## Page 82

Additional stylized facts of Bond yield curve

## Page 83

Additional stylized facts of Bond yield curve
Term Structure of ZCB yields Log yields computed from Fama-Bliss prices. Monthly data, 1952:6— 2010:12
64

## Page 84

Part 3: Additional stylized facts of Bond yield curve
• Summary statistics of yields: • Yields are highly correlated • Three year yields correlated with four year • Four year yields correlated with five year • This suggests some common factors drive the whole term structure of interest rates.
• Yields are also highly persistent, and this persistence bears important consequences on derivative pricing.
• The term-structure of unconditional volatility is downward sloping
65

## Page 85

Factors determining the term structure of interest rates

## Page 86

Factors determining the term structure of interest rates
Now that Yields are highly correlated. What are common factors driving the yield curve? Which systematic risk factors affect the entire term-structure of interest rates?
66

## Page 87

Factors determining the term structure of interest rates
How many factors are needed to explain the variation of the yield curve? The standard “duration hedging” portfolio practice relies on the idea that most of the variation of the yield curve is successfully captured by a single factor that produces parallel shifts in the yield curve. How reliable is this idea, in practice?
67

## Page 88

Factors determining the term structure of interest rates
Litterman and Scheinkman (1991) shows that most (95%) of the variation in the U.S. yield curve can be explained by just three unobservable factors: a ”level” factor a “steepness” (or “slope”) factor a “curvature” factor
68

## Page 89

Factors determining the term structure of interest rates
Why just a few (three) factors may explain the yield curve? We should not expect too much difference between a 10Y zero and a 10Y+1day zero and, then, a 10Y+1day zero and a 10Y+2days zero. Repeating this reasoning ad infinitum suggests that most of the yield curve variations may well be driven by common sources.
69

## Page 90

Factors determining the term structure of interest rates

To disentangle these three factors, the authors make an unconditional analysis based on a fixed-factor model.

Suppose that p yields-to-maturity are generated by a linear factor structure with a

fixed number k of factors,

Rt = R¯ + B Ft + ϵt
p×1 p×1 p×kk×1 p1

Rt is the vector of yields,

Ft is the vector of (zero mean) common factors affecting the yields, R¯ is the vector of unconditional expected yields,

ϵt is a vector of idiosyncratic components of the yield generating process, B is a matrix containing the

factor loadings.

70

## Page 91

Factors determining the term structure of interest rates

A concrete example: p=3, k=3

Suppose we have three types of bond, namely, 1-yr Bond, 5-yr Bond, 10-yr Bond.

Suppose we assume these bonds are determined/governed by three factors, hence, k=3

How to express it as a linear factor structure?

⎡ R1,t ⎤ ⎡ R¯1 ⎤ ⎡ B11 B12 B13 ⎤ ⎡ F1,t ⎤ ⎡ ϵ1,t ⎤

⎢ ⎣

...

⎥=⎢ ⎦⎣

...

⎥+⎢ ⎦⎣

...

...

...

⎥⎢ ⎦⎣

F2,t

⎥+⎢ ⎦⎣

...

⎥ ⎦

Rp,t

R¯p

Bp1 Bp2 Bp3

F3,t

ϵp,t

71

## Page 92

Factors determining the term structure of interest rates

⎡⎤ R1,t

⎡ R¯1 ⎤

⎡

⎤⎡ ⎤

B11 B12 B13

F1,t

⎡⎤ ϵ1,t

•

⎢ ⎣

R2,t

⎥=⎢ ⎦⎣

R¯2

⎥+⎢ ⎦⎣

B21

B22

B23

⎥⎢ ⎦⎣

F2,t

⎥+⎢ ⎦⎣

ϵ2,t

⎥ ⎦

R3,t

R¯3

B31 B32 B33

F3,t

ϵ3,t

•

The first return satisfies:

R1,t

=

R¯1

+

∑︁3
j =1

B1j Fj,t

+

ϵ1,t

• Each row of B contains the factor loadings for all the common factors affecting a

given yield, i.e., the sensitivities of a given yield to a unit change in the factors

• Each column of B contains the term-structure of factor loadings, i.e., the sensitivity

of all yields to a unit change of a given factor

⎡⎤ B11

•

Factor loadings regarding the first factor are ⎢ ⎣

B21

⎥. ⎦

Each element tells you the

B31

sensitivity of each asset returns to a unit change in the 1st factor.

72

## Page 93

Factors determining the term structure of interest rates
• Empirical Resuls: • Litterman and Scheinkman (1991) result hold across a number of countries and
sample periods. • How to find and define the factor: relying on Principal Component Analysis (PCA)
• Econometric challenges are mainly because the vector of factors F is un-observable. • Hence, we need to use PCA.
73

## Page 94

PCA
The main idea of PCA is to transform the original p correlated variables R into a set of new uncorrelated variables, the principal components. These principal components are linear combinations of the original variables, and are arranged in order of decreased importance: the first principal component accounts for as much as possible of the variation in the original data.
74

## Page 95

Factors determining the term structure of interest rates
• Bottom: Changes in the term-structure of interest rates generated by changes in the “level,” “slope” and “curvature” factors. • The dashed line is the yield curve obtained under a negative shock in each factor.
75

## Page 96

Factors determining the term structure of interest rates
• Interpretation of Factors: • “level” factor
• its changes lead to parallel shifts in the term-structure of interest rates. • it produces essentially the same effects on the term-structure as those underlying the
“duration hedging” portfolio practice. • it explains approximately 80% of the total variation of the yield. curve
76

## Page 97

Factors determining the term structure of interest rates
• Interpretation of Factors: • “steepness”/“slope” factor
• its variations induce changes in the slope of the term-structure of interest rates. • after a shock in this steepness factor, the short-end and the long-end of the yield
curve move in opposite directions. • it explains approximately 15% of the total variation of the yield curve
77

## Page 98

Factors determining the term structure of interest rates
• Interpretation of Factors:
• “curvature” factor • its changes lead to changes in the curvature of the yield curve
• In mathematics, curvature is a concept in geometry. Intuitively, the curvature is the amount by which a curve deviates from being a straight line, or a surface deviates from being a plane.
• following a shock in the curvature factor, the middle of the yield curve and both the short-end and the long-end of the yield curve move in opposite directions.
• it accounts for approximately 5% of the total variation of the yield curve
78

## Page 99

Factors determining the term structure of interest rates
• Question: But what is the Economic origin of these factors? • Hard to answer.
• Short end of the yield curve
• For example, macro-economists explain that central banks affect the short end of the yield curve, by inducing variations in Federal Funds rate in the U.S.
• However, Fed decisions rest on the current macroeconomic conditions.
• Therefore, we should expect that the short-end of the yield-curve is related to the development of macroeconomic factors. • Ang and Piazzesi (2003) demonstrate that macroeconomic factors such as inflation and real economic activity are able to explain movements at the short-end and the middle of the yield curve
79

## Page 100

Factors determining the term structure of interest rates
• Long end of the yield curve
• the development of the long-end of the yield curve should largely depend on the market average expectation and risk-aversion surrounding future interest rates and economic conditions.
• Financial economists, then, should expect to see the long-end of the yield curve as driven by expectations of future economic activity and by risk-aversion.
• Ang and Piazzesi (2003) show that the long-end of the yield curve is driven by unobservable factors. It is not clear, however, whether such unobservable factors are driven by time-varying risk-aversion or changing expectations
80

## Page 101

Key Takeaways
The compelling lesson for practitioners is that reduced-form models with only one factor are unlikely to perform well
81
