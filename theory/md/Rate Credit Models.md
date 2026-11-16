# Rate Credit Models

Source: `theory/Rate Credit Models.pdf` (373 pages)

> **Note on this conversion.** The PDF fonts carry no Unicode map for math symbols, so
> most Greek letters and formulas are missing or scrambled below. The prose is reliable.
> For the formulas used in the project (PCA, Vasicek, CIR, stochastic volatility) see
> `models_reference.md`, transcribed by hand from the page images.
> Page headings use the PDF page number; the printed slide number is PDF page - 1.


## Page 1

Interest Rate and Credit Risk Models∗
°c 2006-2026 by Antonio Mele USI Lugano, Swiss Finance Institute and CEPR
Lecture notes, Fall Term 2025
∗These notes are prepared solely in support of these lectures and cannot be further distributed without the written consent of the author
— Typeset by FoilTEX —

## Page 2

These notes are based on lectures delivered since 2006: Masters in Finance & Economics, London School of Economics: 2006-2012; Masters in Finance, Imperial College London: 2012-2013; and Masters in Finance, Swiss Finance Institute at USI Lugano: 2011-2026
Most of this material is available through Mele, A. (2022): Financial Economics. Boston: MIT Press

Overview

1

## Page 3

DISCLAIMER
The author does not accept any liability for any losses related to the use of these lecture notes, for any purpose

Overview

2

## Page 4

Overview

Overview

3

## Page 5

Course overview and objectives

The economic signiﬁcance of the ﬁxed income markets

• The market for ﬁxed income products is surely one of the largest security markets. Nearly two-thirds of the market value of all the securities that are outstanding in the world are classiﬁed as “ﬁxed income securities”.
— Government debt — Corporate borrowing — Fixed income derivatives — Securitized assets — Credit risk transfers

Overview

4

## Page 6

Numbers

• Bank for International Settlements (BIS), 2019
— Notional amount outstanding in the global over-the-counter (OTC) derivatives market = nearly $600 trillion. Of this notional amount, ∗ foreign exchange contracts ≈ $92 trillion ∗ equity-linked contracts ≈ $6.8 trillion ∗ interest rate derivatives ≈ $449 trillion.
• Thus, OTC markets are predominantly about interest rate derivatives
• Interest rate products are also listed on exchanges such as Chicago Mercantile Exchange, Eurex or NYSE LIFFE
— In the dollar case, BIS reports for the 2019 year notional values for futures contracts of ∗ interest rate derivatives ≈ $35 trillion ∗ forex derivatives ≈ $272 billion
— option value is  $60 trillion for interest rate contracts and ≈ $116 billion for foreign exchange

Overview

5

## Page 7

Some additional statistics

• Note. These ﬁgures refer to notional values
— Gross market values are much less than those reported in the previous picture — Gross market values are calculated using the replacement costs of all outstanding
contracts ∗ for example, in 2019 interest rate contracts ≈ $8.35 trillion ∗ Still, according to Veronesi (2016), gross market values of interest rate derivatives
were between 25% and 30% of global GDP from 2007 to 2013, approximately half of the total market capitalization of G-20 countries in 2012.

Overview

6

## Page 8

Complexity of the ﬁxed income markets

• Many instruments in the ﬁxed income markets diﬀer substantially from those in the remaining portions of the capital markets.
— For example, a simple instrument such a pure discount bond is very diﬃcult to price. Intuitively, the price of a pure discount bond reﬂects the time value for money. It is related to the intertemporal preferences and beliefs of the market participants, which are unobservable.
— The situation is diﬀerent in the case of traditional “relative pricing”, in which we price a number of assets given the price of some other assets, while ensuring that there are no arbitrage opportunities “left on the table”.
— In this case, we can evaluate derivatives without reference to any preferences or beliefs. The Black & Scholes formula, for example, is a preference free formula.
• The rapid growth in the ﬁxed income markets was also led by many new instruments that are substantially more complex than the traditional plain vanilla bonds (i.e. default-free, non-callable bonds, defaultable bonds).
— Credit risk transfers — Baskets of ﬁxed income instruments — Callable bonds (i.e. the borrower can “call” the contract to anticipate the payment
of the principal).

Overview

7

## Page 9

• The standard tools of asset evaluation are unlikely to work in this context.
• For example,
— We can’t “adapt” such models as the Black & Scholes model to price interest rate derivatives.
— Indeed, the Black & Scholes model relies on the assumption of a constant volatility of the asset price underlying the contract. In the context of interest rate derivatives, instead, the volatility of the underlying asset price depends on the maturity of the underlying (tends to zero as the maturity goes to zero).
• More generally, pricing and hedging interest rate derivatives requires a model that describes the evolution of the entire term structure of interest rates. Academics and practitioners have proposed a variety of solutions to this problem, from the mid 80s to the beginning of the 90s.
• Today, dozens of new methods are available to price ﬁxed income products.
• The general principles underlying the APT (“arbitrage pricing theory”) are still the same, though.

Overview

8

## Page 10

Many paradigms

• While dozens of new methods are available to price ﬁxed income products, we do not see the emergence of a “single” model to price all of the extant ﬁxed income products!
— Market participants use diﬀerent models to price interest rate derivatives. — Typically, a single investment bank has a “battery” of diﬀerent models with which
to “ﬁght” in the market. — Pieces of this “battery” may ﬁght for diﬀerent goals. For example, an investment
bank might display a preference for a certain type of models as a result of ∗ Its culture and history (see, e.g., the intellectual legacy of Fisher Black and
Emanuel Derman in Goldman) ∗ The particular business the bank is pursuing. For example,
· We shall see that to price “caps” (which are options on interest rates), we may use the so-called market model, which relies on the “Black 76” formula. However, using this model implies that we do not have a “closed form” solution1 for the price of “swaptions”, which can only be solved through numerical methods. If the “swaptions” business is not important for the bank then, we may safely adopt the market model.
· Otherwise, we should invest in additional human capital to support the pricing of these derivatives through numerical methods.

1Heuristically, a “closed form” solution is a solution that can be expressed in one equation, rather than by an algorithm.

Overview

9

## Page 11

Course objectives

• This course provides a thorough grounding in recent developments in ﬁxed income securities pricing, hedging and portfolio management that insists on both conceptual evaluation methods and the many details arising in market practice. By the end of the course, you will be familiar with a variety of topics, including:
(i) the institutions, organization and conduct of the ﬁxed income markets; (ii) the basic techniques to analyze and hedge ﬁxed income products, such as
“curve ﬁtting,” “bootstrapping,” duration, convexity, duration-based hedging and asset-liability management; (iii) the analysis of the “destabilizing” eﬀects related to the use of certain ﬁxed income derivative products; (iv) the economic forces, or “factors,” driving the variation in the entire spectrum of interest rates at diﬀerent maturities; (v) relations between the yield curve and macroeconomic developments; (vi) introduction to the main evaluation tools used in the industry practice (trees, no arbitrage trees, calibration of the yield curve, and continuous time models), applied to a consistent pricing and hedging of a wide range of products, including government bonds, corporate bonds (convertible, callable, puttable), plain vanilla interest rate derivatives (bond options, interest rate swaps, caps, ﬂoors, swaptions, etc.); (vii) the main conceptual approaches to analyze credit markets;

Overview

10

## Page 12

(viii) an introduction to evaluation and hedging of the main credit derivatives such as total-return swaps, spread options and credit default swaps;
(ix) the process of securitization and the resulting structured products, with particular reference to collateralized debt obligations and mortgage-based securities;
(x) an overview of the main evaluation models of sovereign default.

Overview

11

## Page 13

Emphasis of the course and prerequisites

• The course emphasis is on the application of the models, not their mathematical foundations — But it would be misleading to state this course is “mathematics-free.”
• However, the models we shall see are representative of the current “industry practice”. • A few classes will be devoted to analyze real world “case studies”

Overview

12

## Page 14

Sources for this course

• The source for this course is a comprehensive set of lecture notes, based on Chapters 12 through 14 of my book: (i) Mele, A. (2022). Financial Economics. MIT Press: Cambridge, Mass.
• Additional and useful references can be found in the following “classics” (in alphabetical order)
(ii) Brigo, Damiano and Fabio Mercurio (2006). Interest Rate Models–Theory and Practice, with Smile, Inﬂation and Credit. Springer Verlag (2nd Edition).
(iii) Duﬃe, Darrell and Kenneth Singleton (2003). Credit risk. Pricing, management and measurement. Princeton: Princeton University Press (Princeton Series in Finance).
(iv) Sundaresan, Suresh (2011). Fixed Income Markets and Their Derivatives (Third Edition). Academic Press, Elsevier Publishers.
(v) Veronesi, Pietro (2010). Fixed Income Securities. John Wiley & Sons. (vi) Veronesi, Pietro (2016) (Editor). Handbook of Fixed-Income Securities. Handbook
Series in Financial Engineering and Econometrics. John Wiley & Sons.

Overview

13

## Page 15

Course outline

Chapter 0: Institutions and introductory details

— Classiﬁcation of ﬁxed income securities and their related risks — Reviews of basic tools and facts regarding ﬁxed income securities markets

Part I: Interest rates
Chapter I: Empirical properties of interest rates — The yield curve and the business cycle — Factors determining the term structure of interest rates Chapter II: Foundational issues on interest rate modeling — Modeling interest rates with trees — Reverse engineering; implied interest rate trees — A few continuous time models Chapter III: Introduction to the industry modeling practice — No-arbitrage models — Calibration — The market model Chapter IV: Interest rate derivatives — Bond options, interest rate swaps, caps, ﬂoors, swaptions — Counterparty risk — Callable and convertible bonds

Overview

14

## Page 16

Part II: Credit risk

Chapter V: Conceptual approaches to valuation of defaultable securities — Structural approaches to evaluation — Intensity-based evaluation Chapter VI: Credit-risk shifting derivatives and structured products — Total-return swaps; spread options — Credit default swaps — Collateralized debt obligations; Nth to default; mortgage-based securities

Overview

15

## Page 17

Chapter 0 Institutions and introductory details

## Page 18

0.1 General overview

Table of contents

0.2 Classiﬁcation of debt securities

0.3 The risks related to ﬁxed income products

0.4 Markets for interest rates

0.5 Elementary facts about interest rates

0.6 Duration and convexity

0.7 Duration hedging and asset liability management

0.8 The yield curve and forward interest rates

* Appendix

Chapter 0: Institutions and introductory details

17

## Page 19

0.1 General overview

• The aims of this chapter are
(i) to introduce deﬁnitions and terminology arising within the ﬁxed income world (ii) to explain the diﬀerent classes of ﬁxed income products (iii) to explain the risks we bear by trading ﬁxed income products

Chapter 0: Institutions and introductory details

18

## Page 20

What are ﬁxed income securities?

• Fixed income securities are ﬁnancial claims–typically relating to interest rate developments or, credit conditions of ﬁrms, governments or households
• The cash ﬂows promised by the issuers to the buyers of the claims represent contractual obligations.
• Typically, the buyers of these ﬁxed income instruments have the right to take control of the issuers if the obligations are not met
• Fixed income securities are traded in secondary markets, which are typically organized as dealer markets or over-the-counter markets that are spread all over the world.

Chapter 0: Institutions and introductory details

19

## Page 21

Issuers of ﬁxed income securities include

- Governments (e.g., the UK Treasury, the US Treasury, etc.) - Corporations (e.g., Exxon, GM, etc.) - State and municipalities (e.g., New York City) - Banks (e.g. Citibank, Barclays, etc.) - Special-purpose vehicles

Institutional and retail investors (the buyers) include

- Governments - Central banks (! ⇐= Quantitative Esasing) - Pension funds - Insurance companies - Mutual funds - Commercial banks - Households

Financial intermediaries

Chapter 0: Institutions and introductory details

20

## Page 22

- Dealers - Investment banks - Credit rating agencies, credit and liquidity enhancers

Chapter 0: Institutions and introductory details

21

## Page 23

Objectives of the issuers

• To receive the fair value for their securities • To have orderly and liquid secondary markets in their securities
— A “good” secondary market ensures that transactions can be made under “good” conditions. In anticipation of this, the price of the securities issued in the primary market will behave to reﬂect the fundamentals of the issuers, and not just an “erratic” and illiquid behavior of the secondary market
• Some issuers would like to reverse and modify earlier issuance decisions in response to market conditions eﬃciently
— For example, issuers who anticipate that their future credit ratings will improve might put call features in their debt issue if the market does not share their optimism about the future potential for improved credit reputation (diﬀerences in beliefs). A concrete instrument that allows to do this is a callable bond, which allows the issuer to repurchase the bond at some price and at some future date. We shall see that issuing a callable bond raises the cost of capital to the extent of the “embedded option” implicit in the contract. Some investors might be interested in this type of “timing-risk” - return proﬁle.
— Other corporations might want to issue convertible bonds, which are bonds that can be converted into shares of the issuing company. Convertible bonds promise low coupon rates, as the holder has the right to convert them into common stocks, with a conversion ratio which is typically attractive (to the holder). Naturally, after conversion, the shareholder’s equity value will be diluted.

Chapter 0: Institutions and introductory details

22

## Page 24

Other reasons explaining why convertibles are so important:

∗ Convertible bonds are attractive to investors for a variety of additional reasons. One is that they behave as “hybrid” instruments. They do behave like bonds, but at the same time, they might inherit the “good” properties of equities in “good times”. Another reason is related to convertible arbitrage (buy convertibles, short equity).
∗ Convertible bonds are attractive to issuers, as they entail lower borrowing costs (due to the embedded option to convert). Moreover, ﬁxed-rate convertible bonds help, when we expect interest rates to raise in the future.
∗ Convertible callable bonds are bonds that cobverti into equity once TER1 ratios fall by a certain trigger

• Other issuers would like to issue simple noncallable debt securities with a ﬁxed maturity date and a ﬁxed coupon; such securities are referred to as bullet securities.

Chapter 0: Institutions and introductory details

23

## Page 25

Objectives of the investors

• To buy securities of diﬀerent risk-return proﬁle at a fair price • To have access to risk-management services, such as derivatives

Objectives of ﬁnancial intermediaries

• To provide primary market making services, such as bidding the auction, underwriting, and distribution
• To provide orderly market making in the secondary market • To provide risk-management and asset liability management services
— For example, Moody’s or Standard and Poor produce information about the credit quality of diﬀerent issuers, for a fee
• To provide proprietary trading services

Chapter 0: Institutions and introductory details

24

## Page 26

0.2 Classiﬁcation of debt securities

Debt securities, excluding derivatives, are classiﬁed by issuers.

• Treasury, or Sovereign, securities comprise US Treasury securities, UK gilts, etc. • Agency securities are debt securities issued by government agencies, such as the
Federal Home Loan Bank (FHLB), the Federal National Mortgage Association (FNMA), or the Government National Mortgage Association (GNMA) • Corporate securities are debt securities issued by corporations • Mortgage-backed securities (MBS) are securities backed by pools of mortgages • Municipal issues are debt securities issued by state governments and municipalities • Emerging market securities are debt securities issued by less-developed and developing countries • The shares, approximately, in the US market — US Treasury: 45% — MBS: 30% — Corporate: 19% — Agency: 6% • The shares, approximately, by country — US: 46% — Japan: 13%. Germany: 10%. — France: 9%. Italy: 9%. UK: 9%

Chapter 0: Institutions and introductory details

25

## Page 27

• Some important examples developed in the next slides — The US Treasury market — The UK — Agency securities — Corporate securities — Securitized assets

Chapter 0: Institutions and introductory details

26

## Page 28

The US Treasury market

• US Treasury securities are regarded by the investment community as risk-free. Full faith and credit of the US government (economic power and the power to levy taxes)
— Since a large amount of debt securities are issued by the US government, the Treasury has to schedule regular and frequent auctions to sell these securities
• US Treasury securities are auctioned at benchmark maturities. Typically, — 3 months — 6 months — 1 year — 2 years — 5 years — 10 years — 30 years
• Newly auctioned securities are known as on-the-run issues. • Seasoned issues (those issued in previous auctions) are known as oﬀ-the-run issues.
— The bid-ask spreads for oﬀ-the-run issues are typically larger than the bid-ask spreads for on-the-run issues
— Transaction sizes and bid-ask spreads for oﬀ-the-run issues are diﬃcult to predict — Most recently issued on-the-run issues are those about which dealers have the most
information. As the issue gets older (and becomes oﬀ-the-run), dealers may not have the same level of information about which institutions own the securities and in which amounts.

Chapter 0: Institutions and introductory details

27

## Page 29

• Securities issued with a maturity less than or equal to one year (i.e. 3 months, 6 months and 1 year) at the time of issuance are called Treasury bills or T-bills.

— These securities do not pay coupons

• Treasury securities that pay coupons and have maturities in the range of 1 to 10 years at the time of issuance are called Treasury notes or T-notes.

• Treasury securities that have maturities in excess of 10 years at the time of issuance are called Treasury bonds or T-bonds.

— The 30 years T-bond is known as the long bond.

• The US Treasury no longer issues callable bonds

The UK

• Gilt-edged stock or gilts are British government securities.
— Standard gilts carry ﬁxed annual coupons (also known as dividends) and pay the face amount at maturity date
— Index-linked gilts have coupon and face amounts indexed to the UK retail price index — Convertible gilts may be converted into one or more other gilts at speciﬁc dates and
conversion ratios — Irredeemable gilts are “perpetuals”, with no maturity date

Chapter 0: Institutions and introductory details

28

## Page 30

Agency securities

• Government-sponsored enterprise (GSEs) are private corporations that operate under a charter from the US Congress. The majority of its board of directors are elected by private shareholders.
— They serve as ﬁnancial intermediaries, and issue debt. — Agency securities have a quite high credit reputation. The pressure from the US
Congress to examine the guarantees issued by the government to agencies causes the agencies to acquire a high standalone credit reputation. — Their activities include making loans and loan guarantees to borrowers in certain sectors of the economy identiﬁed in the legislation — GSEs are perceived by investors to have an implicit federal government guarantee backing their obligations — Agency securities are not direct obligations of the federal government. Even though the probability of default is very small, they trade at a spread to comparable Treasuries. ∗ A possible factor is that agency securities are issued in relatively smaller size
compared to Treasuries and as a result are not as liquid. — Examples
∗ Federal National Mortgage Association (FNMA) and Federal Home Loan Mortgage Corporation (FHLMC) were created to promote a liquid secondary market. (Sort of.................)

Chapter 0: Institutions and introductory details

29

## Page 31

∗ Tennessee Valley Authority (TVA) was created to promote the Tennessee River region
∗ Student Loan Marketing Association (SLMA) promotes a liquid secondary market for government guaranteed students loans (loans are insured)
∗ Farm Credit System (FCS) provides low-cost credit to agriculture and ﬁsheries. It has considerable political support.

Corporate securities

• The corporate ﬁxed income securities market has been the dominant way of raising capital for US corporations in the last few years.
— Much like the Treasury market, the market for corporate issuances may be quite active – however, secondary market may be quite idle.
— The seasoned issues, which have been issued a few months earlier, tend to be illiquid and trade at wider bid-ask spreads
— Unlike the Treasury issues, most corporate issues tend to have call features or sinking fund features (deﬁned more precisely below).
— Call features also permit managers to eliminate debt, if necessary ∗ Debtholders might place restrictive covenants that may not allow managers to undertake certain investments or may prohibit certain types of mergers and acquisitions ∗ By having a call feature, managers give themselves the right to take such actions at a predetermined (call) price

Chapter 0: Institutions and introductory details

30

## Page 32

— Along the maturity spectrum, we have ∗ Short maturities under one year are in the money markets sector · The key corporate debt here is the commercial paper (CP). Its maturity varies from 30 days to 270 days. CPs, like T-bills are discount instruments (do not pay coupons). Typically, CP is discounted oﬀ the London Interbank Oﬀered Rates (LIBOR) of comparable maturities. The LIBOR is the rate at which banks are able to borrow money in the interbank market, which is not subject to US regulations. More on the LIBOR below. · Some corporations, by virtue of their strong credit reputations, are able to borrow directly from the public at rates that are lower than what they could get at banks ∗ In the one- to ﬁve-year sector are the medium-term notes · They can be issued through shelf registration. In a shelf registration, the issuer gets blanket approval from the SEC for an amount of debt that may be issued over a prespeciﬁed period of time, which gives the issuer the ability to respond quickly to any rapid changes in interest rates ∗ Finally, longer maturities come under the corporate bonds classiﬁcation. ∗ Corporate debt is rated by rating agencies, such as Moodys and Standard and Poors. Depending on the rating, corporate debt may be either investment grade or non-investment grade (“junk”). · Moodys rating go from Aaa to C · Standard and Poor’s go from Aaa to D

Chapter 0: Institutions and introductory details

31

## Page 33

Securitized assets

• Securitization is a process by which illiquid assets are transformed (or “structured”) into relatively more liquid ﬁnancial instruments.
— The leading example: Mortgage-backed securities
• The securitization process involves several steps.
(i) It begins with an originator, which can be a private institution. The originator creates individual mortgages or receivables.
(ii) The assets are pooled from a number of originators. The pool of assets must be large to attract interest of large institutional investors. Then, the assets are standardized along several dimensions such as maturity, the interest rate (ﬁxed or adjustable), geographical location of the loan, etc.
(iii) For a fee, a standardized portfolio is then guaranteed by a federal agency (or a private entity of suﬃciently high reputation) against default. ∗ Such defaults may occur at the level of individual units in the pool (such as a particular homeowner in a pool of mortgages) or at the level of issuers. ∗ Both classes of default are covered by guarantees.
• So standardization & guarantees enhance the marketability of the securities that are then issued as claims to the guaranteed cash ﬂows from the pool of assets. Finally,
(iv) A Special Purpose Vehicle (SPV) is created to construct the pool of ﬁnancial assets and issue the asset-backed securities to ﬁnancial intermediaries (which will then intermediate these securities to institutions and retail investors).

Chapter 0: Institutions and introductory details

32

## Page 34

• Issuing vehicles

— Grantor trust, which simply “passes through” principal & interest from the loan

pool to investors. — Owner trust, which creates multiple-class securities with diﬀerent maturities, which
appeal to a broader range of investors. Here, principal payments do not necessarily

mirror the underlying cash-ﬂow patterns of the collateral.

Chapter 0: Institutions and introductory details

33

## Page 35

0.3 The risks related to ﬁxed income products

Contractual cash ﬂows

• Typical bullet debt securities are US Treasury bonds, which pay a periodic compensation, known as coupon, and the face value at maturity. These securities are said to be default free
• A default free security involves other types of risk, typically an interest rate risk and even a liquidity risk.
— Interest rate risk. For example, the market conditions may be aﬀected by the monetary policy of the Federal Reserve, which aﬀects the short-end and the middle of the term structure of interest rates. In turn, monetary policy reacts to macroeconomic conditions. Finally, the market reacts to the signals it receives about the future macroeconomic conditions and the monetary policy decisions. Therefore, the evolution of the term structure of interest rates depends on the future macroeconomic conditions, monetary policy rules, and market expectations. These are diﬃcult to forecast and, hence, contribute to the interest rate risk
— Liquidity risk. High liquidity means that investors stand ready to buy or sell large amounts easily at a narrow bid-ask spread without an adverse price reaction. However, there may be period of liquidity shortage, especially during periods of crisis. ∗ Consider, for example, the 1998 LTCM downturn. The LTCM was an hedge fund that leveraged signiﬁcantly to invest in “relative value” strategies in which

Chapter 0: Institutions and introductory details

34

## Page 36

the fund attempted to proﬁt from “temporary price discrepancies” between two

markets (e.g., long the cheaper “oﬀ-the-run” bonds and short the more expensive, but more liquid, “on-the-run” bond). ∗ The motivation was that the spread would narrow and that the trade would unwound at a proﬁt. ∗ Since these diﬀerences in value are tiny, a large amount of leverage was needed. ∗ In August 1998, Russia declared a “debt moratorium”, and credit spreads widened dramatically all over the world. ∗ LTCM’s position on a “market-to-market” basis became precarious. The fund had to raise capital or sell assets to meet the losses from marking-to-market. ∗ This liquidity pressure contributed to panics, and liquidity conditions even worsened. ∗ The LTCM was taken over by a plan orchestrated by the Federal Reserve Bank of New York. ∗ Arguably, a very bad period for anyone wishing to sell “safe” bonds

• Other types of risk

— Event risk. This risk arises if the issuer’s credit risk suddenly deteriorates or a major

recapitalization (such as a leveraged buyout) occurs, adversely aﬀecting the risk of

the bond. (For example, the newly re-cap company might invest in a more risky business.)

— Timing risk. Some debt securities are callable.

Chapter 0: Institutions and introductory details

35

## Page 37

• Provisions. Debt securities sold by issuers that are subject to a probability of default typically contain two important contingency provisions.
— First, debt contracts specify events that precipitate bankruptcy, the so-called lower reorganization boundary. One example is the event that the issuer does not pay the promised coupon payment. Another example is the event that the issuer does not pay the principal, or the face value (also known as balloon), at maturity. ∗ These events give the debtholders the right to take over the ﬁrm ∗ However, the debtholders may waive their right to take over, if they feel they could do better by renegotiating with the managers.
— Second, the debt contracts also specify the rules by which debtholders will be compensated upon bankruptcy and transfer of control.
— It has to be noted that renegotiation may lead to deviations from absolute priority rules, whereby senior claimholders must be paid before any payments are made to junior claimholders.
• Other examples of provisions
— Most corporate debt issues are callable at predetermined prices, which gives the issuer the right to buy back the debt issue at prespeciﬁed future times.
— Most are issued with sinking fund provisions, which require that the debt issue be periodically retired in predetermined amounts. Some debt issues can be puttable at the option of the buyer
— Some debt issues can be convertible into a prespeciﬁed number of shares of common stocks of the issuing company. Most convertible securities are also callable

Chapter 0: Institutions and introductory details

36

## Page 38

0.4 Markets for interest rates

There are three main types of markets for interest rates: (i) LIBOR; (ii) Treasure rate; (iii)

Repo rate (or repurchase agreement rate).

• LIBOR (London Interbank Oﬀer Rate) and other interbank rates
— Many large ﬁnancial institutions trade with each other deposits for maturities ranging from just overnight to one year at a given currency. The LIBOR is the rate at which ﬁnancial institutions are willing to lend each other, on average. It is an average indicative quote of the interbank lending market. It was once calculated by Thomson Reuters for a number of currencies, and published daily by the British Bankers Association. It is currently administered by Intercontinental Exchange
— Instead, the LIBID (London Interbank Bid Rate) is the rate that these ﬁnancial institutions are prepared to pay to borrow money, on average. Normally, LIBID  LIBOR. The LIBOR is a fundamental point of reference to ﬁnancial institutions, who look at it as an opportunity cost of capital. Moreover, many ﬁxed income instruments are indexed to the LIBOR: forward rate agreements, interest rate swaps, or variable mortgage rates.
• LIBOR has been progressively (and, in 2022-2023, deﬁnitely) phased out and replaced in the United States by the Secured Overnight Financing Rate, also known as SOFR
• Many models for evaluating Fixed Income derivatives were based on LIBOR–they were known as LIBOR models
— For simplicity, we shall keep on referring these models as LIBOR models

Chapter 0: Institutions and introductory details

37

## Page 39

• The Federal Funds rate
— LIBOR reﬂects market conditions re: the banking system — The US Federal Funds rate applies to deposits with the Federal Reserve
∗ Banks need maintain reserves with the Federal Reserve (partially back deposits and/or clear ﬁnancial transactions)
∗ Banks with excess reserves (with the Fed) earn zero interest. They may then lend to banks with reserve deﬁciencies
∗ The Federal Funds rate is the overnight rate at which banks lend these reserves to each other
∗ Aﬀected by the FDRBNY – ﬂuctuates within a range of the target rate decided by the Federal Open Market Committee (FOMC) – Implemented thru open market operations.
• Treasury rate
— This is the rate at which a given Government can borrow at a given currency.
• Repo rate (or repurchase agreement rate)
— A Repo agreement is a contract by which one counterparty sells some assets to the other one, with the obligation to buy these assets back at some future date. The assets act as collateral. The rate at which such a transaction is made is the repo rate. One day repo agreements give rise to overnight repos. Longer-term agreements give rise to term repos.

Chapter 0: Institutions and introductory details

38

## Page 40

• Spreads
— Interest rate spreads isolate interesting pieces of information, as they remove common components of the interest rates generating the spreads, which we are not interested in. An important example stems the overnight interest swap rate (OIS), which is the swap rate in a swap agreement of ﬁxed against variable interest rate payments, where the variable interest rate payments are made of an overnight reference, typically an average, unsecured interbank overnight rate, such as the Federal Funds rate in the US, SONIA in the UK or EONIA in the Euro area. ∗ An interesting indicator is the “3-month LIBOR − 3-month OIS” spread, also known as the LIBOR-OIS spread. Because payments relating to overnight rates are not subject to default risk, and the overnight rate is “anchored” to monetary policy, the LIBOR-OIS spread is capable of isolating credit views about ﬁnancial institutions. It is generally ﬂat, although then it reached high record levels during the 2007 subprime crisis. ∗ The so-called TED (Eurodollar LIBOR − Treasury bill rate) spread also captures “ﬂight to quality” eﬀects occurring during times of crisis, when Treasury bonds are considered particularly valuable. For this “ﬂight to quality” reason, the TED spread might fail isolate views about developments in the interbank market.

Chapter 0: Institutions and introductory details

39

## Page 41

Interest rates
8% 3m LIBOR

4.5%

3m T-Bill rate

7%

10 Year Treasury yield

4%

3.5% 6%
3%
5% 2.5%

Spreads
TED spread LIBOR - OIS spread

4%

2%

1.5% 3%
1%
2% 0.5%

1% 1995

2000

2005

2010

2015

2007 2008 2009 2010 2011 2012

Figure 1. Spreads

Chapter 0: Institutions and introductory details

40

## Page 42

• On a historical note, the Federal Funds rate has been the object of much empirical research. In an attempt to explain how the “credit view” contributes to growth more than Friedman’s monetary view, Bernanke and Blinder (1992) show that the Federal Funds rate makes the predicting power of M1 growth insigniﬁcant. This ﬁnding initially spread enthusiasm about the ability of this rate to explain short-run aggregate ﬂuctuations. However, as surveyed for example by Stock and Watson (2003), the explanatory power of the Federal Funds rate evaporates, once we condition on the term spread.

Chapter 0: Institutions and introductory details

41

## Page 43

0.5 Elementary facts about interest rates

Bonds, zeros and spot rates

Let 1 2 · · ·   ≡  be a sequence of dates. A bond promises to pay ﬁxed coupons  over this sequence of dates and the principal of $1 at date  .
We denote the price of a bond as of time  as  (  ), where  ≤ 1.

We denote the price of a zero coupon bond (in short, a “zero”) paying the principal of $1 at date  as  (  ).

To simplify notation, we let  ( ) ≡  (0  ) and  ( ) ≡  (0  ). (When we need to emphasize the time dependence, we shall keep on using the notation  (  ) and  (  ).)

The spot rate for some maturity date  is the yield on the zero maturing at  , denoted as  ( ).  ( ) is the solution to the following equation,

1  ( ) = [1 +  ( )] 

That

is,

1

+



( )

=



(

)−

1 

.

Chapter 0: Institutions and introductory details

42

## Page 44

With semi-annual compounding (which is relevant in the US), we have that  ( ) =

 1+

1
( 2

)

2

.

In

general,

we

have

that

if

the

interest

is

compounded



times

in

a

year,

at

the annual rate , then, investing for  years gives



 

1+





Continuous compounding is obtained by letting  → ∞ in the previous expression, which leaves  . Therefore, the continuously compounded spot rate is obtained as

1  ( ) = − log  ( ) 


Bonds In the absence of arbitrage opportunities,
 ( ) = 1 (1) + · · · + ( + 1)  () 

Chapter 0: Institutions and introductory details

43

## Page 45

Yield to maturity

The yield to maturity ˆ (YTM, henceforth) on a bond is its rate of return. It is the

discount rate that would equate the present value of the stream of payoﬀs with its market

price,



( )

=

 
=1

(1

 + ˆ)

+

(1

1 + ˆ) 

(1)

This

formula

diﬀers

from

the

price

formula



( )

=


=1


[1+()]

+

1 [1+( )]

,

as

Eq.

(1) uses the same discount rate ˆ to discount the future payements. Clearly, for zeros we

have that spot rates coincide with YTM, i.e. ˆ =  ( ).

Forward rates

The forward rate agreed at time  is the interest rate on a given principal in a future time-interval [ ], and is denoted as  (  ). This agreement will be enforced at time  but costs nothing at time . The one-period forward rate,  (   + 1), relates to the time-interval [  + 1], and is denoted as

 () ≡  (   + 1) 

Chapter 0: Institutions and introductory details

44

## Page 46

In the absence of arbitrage,

 (  + 1)

1

=



(2)

 (  )

1 +  ()

Indeed, an investor in a zero from time  to time  + 1 is one who simultaneously makes (i) a spot loan from  to  , and (ii) a forward loan from  to  + 1. In the absence of arbitrage, it must be the case that,

[1

+



(

+

1)]

+1−


=

[1

+



(



)]

−


×

[1

+



()]

zero loan

spot loan

forward loan

where  (  + 1) is the spot rate at time , deﬁned as the solution to,  (  ) = 1/ [1 +  (  )] −.

Eq. (2) then follows by the deﬁnition of  (  + 1), and by rearranging terms in the previous basic equality.

Hence, the forward rate can be “read” from the current prices of the zeros, at least insofar as we’re able to “read” zeros, an issue we now address in detail.

Extracting zeros from bond prices

In principle, the zeros can be “extracted” from the market price of the bonds, provided there is a suﬃcient spread of bonds across maturities.

Chapter 0: Institutions and introductory details

45

## Page 47

For example, consider three bonds. The ﬁrst bond pays oﬀ at 1, the second bond pays oﬀ at 1 2, the third bond pays oﬀ at 1 2 3. By no-arbitrage,

 (1) = (11 + 1)  (1)  (2) = 21 (1) + (22 + 1)  (2)  (3) = 31 (1) + 32 (2) + (33 + 1)  (3)

for some coupons . That is, in matrix format,





 (1)

11 + 1

  (2)  =  21

 (3)

31

0 22 + 1
32





0

 (1)

0    (2)  

33 + 1

 (3)

Therefore, we can use the observed prices  ( ) and the payments  to calculate the zeros  ( ) as,





 (1)

11 + 1

0

  (2)  =  21 22 + 1

0

−1   (1) 

0    (2)   (3)

 (3)

31

32

33 + 1

 (3)

The previous procedure can be generalized to the case in which “some maturity is missing”. The resulting algorithm is known as the bootstrap, and is described in the appendix.

Chapter 0: Institutions and introductory details

46

## Page 48

Curve ﬁtting

Alternatively, we may use statistical techniques to cope with situations in which the number of bonds does not equal the number of maturity dates.

Suppose we observe  bonds, where the -th bond entitles to receive the coupons , for  = 1 · · ·  . We assume that the bond prices are observed with errors, or

 



 () =  () +   + ,

=1

 = 1 · · ·  

where  is the measurement error for the -th bond. We aim to ﬁnd the curve  → 7  ( ) that minimizes the errors, in some statistical sense.

• The natural thing to do is to “parametrize” the function  ( ), with a number of  parameters, where   . To parametrize the function  () for a generic , we can use polynomials, as originally suggested by McCulloch (1971, 1975),
 () = 1 + 1 + 22 + · · · +  
where the  are the parameters.

Chapter 0: Institutions and introductory details

47

## Page 49

• Cubic splines are polynomials up to the third order, and are very popular.1

• The=1par2a.meters  can be estimated by minimizing the sum of the squared errors, • Naturally, we may also want to parametrize the spot rates,  ( ), as polynomials.
Alternatively, Nelson and Siegel (1987) propose the following parametrization,









 ( ) = 1 + 2

1 − − 

+ 3

1 − − − − 



where  and  are the parameters. These coeﬃcients may be given an interpretation, in terms of the factors driving the yield curve, reviewed later.
— 1 governs the level of the yield curve. 2 relates to the slope, as an increase in this coeﬃcient increases short yields more than long yields. 3 shapes the curvature, as an increase in this coeﬃcient has little eﬀect on very short and very long yields, but increases the middle of the yield curve.
— Moreover,  controls the exponential decay of the yield curve: small values of  translate to slow decay and can better ﬁt the curve at long maturities; large values of , instead, lead to a fast decay, which helps ﬁt the short-end of the yield curve. Finally,  determines where the loading on 3 achieves its maximum.
1A well-known pitfall of polynomials is that a high  might imply that while the polynomial approximation works reasonably well near the observed maturities, it may exhibit an erratic behavior in between. To avoid this problem, we can use local polynomials, which are low-order polynomials (typically splines) ﬁtted to non-overlapping subintervals.

Chapter 0: Institutions and introductory details

48

## Page 50

— Diebold and Li (2006) have used this setting to estimate  for each date, and then used these estimated time series of  to forecast future values of  through vector autoregressions and, then, the future yield curve.

Chapter 0: Institutions and introductory details

49

## Page 51

0.6 Duration and convexity

• The risk of going long a default-free bond is that the future bond price is uncertain, due to the possibility that the spot interest rates could change in the future.

• Synthetically, we can say that the risk of a bond is related to the changes in the required bond return, or the YTM.

Consider the deﬁnition of the YTM ˆ in Eq. (1),



( )

=

 
=1

(1

 + ˆ)

+

(1

1 + ˆ) 

We explained that ˆ is the rate of return that equates the discounted ﬂow of coupons to the market price,  ( ).

More generally, we may consider the following function  (;  ),



(;  )

=

 
=1

(1

 + )

+

(1

1 + )



This function aims to “mimic” how the market price  ( ) would behave if the YTM ˆ changed to some value . Naturally,

 (ˆ;  ) =  ( ) 

Chapter 0: Institutions and introductory details

50

## Page 52

• Motivated by the previous remarks, we can deﬁne a measure of risk of the bond based on the sensitivity of the bond price with respect to changes in .

— Economically, we are trying to answer the following question: What happens to the bond price once we perturb the one rate ˆ that discounts all the payoﬀs?
— Mathematically, this sensitivity is the ﬁrst partial of the “bond-pricing” formula  (;  ) with respect to ,



(;

)

=

− 1

1 +



 
=1

 ·  (1 + )

+

  ·1 (1 + )

where

the

subscript

denotes

a

partial

derivative,

i.e.

 (;  )

=

 



(;



).

— Graphically, this sensitivity measure  (;  ) is the tangent to the price-yield

relation, as shown in Figure 1 in the next slide.

Chapter 0: Institutions and introductory details

51

## Page 53

Bond price

1

0.9

0.8

0.7

0.6

0.5

0.4

0.3 0

0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09

0.1

YTM

Figure 2. The bond price-yield relation (solid line), its ﬁrst-order approximation (duration) and its second-order approximation (convexity).

Chapter 0: Institutions and introductory details

52

## Page 54

Duration

• We deﬁne the “Macaulay duration” as,

DMac

≡

− (;  )  (;  )

(1

+

)

=

  

·



+

ˆ 

·



=1

where



=

 

(1

+

)

;

 (;  )

1/ (1 + )

ˆ =

  (;  )

— In words, the Macaulay duration is a weighted average of the payment dates.

—

The 

weights  are (1 + ), related

the to

discounted coupons at the various payment dates, the current market value of these coupons, i.e. the bond

price  (;  ) when the YTM is . That is, the weights are the proportions of the

—

Tbohnedw’sepigrhetssenstatviasflyuetha=t1

is attributable  + ˆ =

to 1.

the payoﬀ Therefore,

at date . DMac ≤ 

.

— The Macaulay duration is a measure of how far in the future the bond pays oﬀ. For

zeros, DMac =  .

Chapter 0: Institutions and introductory details

53

## Page 55

• For small , DMac () is simply the semi-elasticity of the bond price with respect to the YTM. This semi-elasticity is also referred to as “modiﬁed duration”,
D ≡ − = DMac   1+

• A simple computation reveals

− 

+


 

2 .

Therefore,

that

the

modiﬁed

duration,

D,

satisﬁes:

D 

=

— The modiﬁed duration is decreasing in the YTM when the bond price is suﬃciently

convex in the YTM, which is surely the case for long-term maturity dates.

— The modiﬁed duration is increasing in the YTM when the bond price is concave in

the YTM, a property that arises for callable bonds and mortgage-backed securities

(MBS, henceforth). Intuitively, the incentives to proceed to early repayments “kick

in” as the YTM decreases, which makes the duration of the MBS decrease.

Chapter 0: Institutions and introductory details

54

## Page 56

• The Macaulay duration for continuously compounded rates is even simpler to compute. — First, deﬁne the continuously compounded YTM as the single number ˆ such that

(ˆ;  ) =   −ˆ· + −ˆ· 
=1

where (ˆ;  ) is the market price of a bond paying oﬀ the principal of one at
maturity and the stream of payoﬀs . — Next, consider, the function  → 7  (;  ). Compute the semi-elasticity of the
bond price  (;  ) with respect to the continuously compounded YTM ,

− (;  )  (;  )

=

 −· + 
=1
 (;  )

· −·

 

=

 ·  + ˆ

=1

· 

—

where Note,

 the

(;  ) =  weights are

(; 
such

)t,hat==1(−;·)+ aˆnd

ˆ = = 1.

−· (; )

.

Therefore,

the

“Macaulay

duration” for continuously compounded rates is equal to the semi-elasticity of the

bond price with respect to the continuously compounded YTM .2 This result may

simplify some calculations.

2Mathematically, we could have obtained this result in a straightforward manner, as follows. Deﬁne the bond price

function as  ( ()), where by deﬁnition,  () =  − 1. Hence,  ( ()) =  ( ()) 0 () =  ( ())  =



( ()) (1

+

).

It

follows

that

DMac

=

− (1+) 

=

− 

.

Chapter 0: Institutions and introductory details

55

## Page 57

Convexity

• Convexity measures how the sensitivity, , changes with . Mathematically, convexity

is related to the second partial of the bond price with respect to , .

• If the second partial, , is positive, then, the interest rate sensitivity declines as 

increases

(see

Figure

2).

This

is

because

 

(−)

=

−



0.

• Formally, convexity is deﬁned as,

C ≡   

An expansion of the bond price

We have, approximately,

∆

≈

−D

·

∆

+

1 C

·

(∆)2 



2

That is, for very “convex securities”, duration may not be a safe measure of return, as also shown in Figure 1.

Chapter 0: Institutions and introductory details

56

## Page 58

0.7 Duration hedging and asset-liability management

• We can use duration to assess how exposed a bond portfolio is to movements in the interest rates.

• We can “immunize” a portfolio of bonds to changes in the interest rates.

• Duration is relevant for asset-liability management. For example, pension funds have known streams of liabilities that must be matched by the assets they hold. In words, the duration of the assets must equal the duration of the liabilities.

• In the UK, pension funds must mark-to-market the liabilities. Therefore, one objective of these funds is to “immunize” their liabilities against movements in the interest rates.

• Alternatively, consider the following basic example. A bank borrows $100 at 2% for a year and lends this money at 4% for 5 years, where the higher rate compensates for many things such as risk, the bank’s market power, etc. Assuming that the bank’s borrower does not default, in the ﬁrst year, the bank generates proﬁts equal to $ (4% − 2%) ∗ 100 = $2, according to its books.

— However, the right computation to make should not relate to past market (interest

rate) conditions, but to the current ones.

— Suppose for example that in one year, the interest rate for borrowing raises from 2%

to 5%, and remains such for 4 additional years. This is of course a bit unrealistic,

but it gives the idea of where the action is. In this case,

∗

The market value of the assets is:

100∗1045 1054

= 10009.

Note, we discount using

the 5% interest rate, as this is the cost of capital for the bank.

Chapter 0: Institutions and introductory details

57

## Page 59

∗ The market value of the liabilities is, of course, 100 ∗ 102 = 102. ∗ The bank’s problem is, of course, a duration mismatch.

Chapter 0: Institutions and introductory details

58

## Page 60

A more substantive example: asset-liability management for pension funds

• Consider the following extreme example
— In 30 years from now, a pension fund is due to deliver $100,000 to some future retiree.
— Suppose the current market situation is such that the yield curve is ﬂat at 4%, such that the market value of this liability is $100 000 ∗ (104)−30 = $30 832.
— Accordingly, the would-be retiree invests $30832 in the pension fund.
So we have the following situation:

Cash Pensions $30 832 $30 832
Suppose, now, that the pension fund does not invest this cash. This is of course ineﬃcient, but it is precisely the point of this simple exercise to see why the strategy is ineﬃcient.

Chapter 0: Institutions and introductory details

59

## Page 61

• Consider two extreme cases, occurring under two scenarios underlying developments in the ﬁxed income market. In one week,
— Scenario ↑: the yield curve shifts up parallely to 5%. Accordingly, the value of the liability for the pension fund is: $100 000 ∗ (105)−30 = $23 138.

Cash

Proﬁt

$30 832 $7 694

Pensions $23 138
— Scenario ↓: the yield curve shifts down parallely to 3%. Accordingly, the value of the liability for the pension fund is: $100 000 ∗ (103)−30 = $41 199.

Cash

Loss

$30 832 −$10 367

Pensions $41 199

Chapter 0: Institutions and introductory details

60

## Page 62

• So a drop in the yield curve results in a loss for the pension fund:
— when interest rates go down, the pension fund faces a challenging situation as it has to honour its obligations in 30 years, but the ﬁnancial market “yields less” than one week ago.
• Naturally, the pension fund would face an opposite situation were interest rates to go up.
• In some countries, we don’t like pension funds to experience volatility.
— The previous volatility arises simply because the pension fund, receives $30 832, and then it just put this money “under the pillow.”
— The most eﬃcient way to kill volatility is, of course, to invest $30 832 in a 30 bond as soon as we receive this money–at the market conditions of 4% ∗ Perfect hedging! ∗ But, we do not necessarily have access to such a bond. ∗ How do we proceed, then?
• The next slides develop examples that illustrate how to deal systematically with issues relating to asset-liability management.

Chapter 0: Institutions and introductory details

61

## Page 63

• Let us consider a portfolio of two bonds with diﬀerent durations. Its value is given by,

 = 1 (ˆ1) 1 + 2 (ˆ2) 2

where 1 (ˆ1) and 2 (ˆ2) are the market value of the bonds, ˆ1 and ˆ2 are the YTM on the bonds and, ﬁnally, 1 and 2 are the quantities of bonds in the portfolio.
• Let us consider a small change in the two YTM ˆ1 and ˆ2. We have,

 = − [D (ˆ1) 1 (ˆ1) 1ˆ1 + D (ˆ2) 2 (ˆ2) 2ˆ2] 

• The question is: How should we choose 1 and 2 so as to make the value of the portfolio remain constant after a change in ˆ1 and ˆ2?

Chapter 0: Institutions and introductory details

62

## Page 64

• Let us assume a parallel shift in the term structure of interest rates. In this case, ˆ1 = ˆ2. The portfolio is said to be immunized if its value  does not change as ˆ1 and ˆ2 change, i.e.  = 0, which is true when,

1

=

D −
D

(ˆ2) (ˆ1)

2 1

(ˆ2) (ˆ1)

2

(4)

A useful interpretation of this portfolio is that we may be holding a bond with some duration, say we hold 2 units of the second bond. Given these holdings, we may wish to sell another bond, possibly with a lower duration, to hedge against movements in the price of the bond we hold.
• Alternatively, we can think of the second asset as a liability the value of which ﬂuctuates after a change in the interest rates. Then, we may wish to purchase some asset to hedge against the liability. Mathematically, 2  0 and 1  0. Moreover, Eq. (4) reveals that the number of assets to hold to hedge against the liability is high if the ratio of the two durations of the assets, D (ˆ2)/ D (ˆ1), is large.
• In this case, the hedging position is obviously ineﬃcient. Asset-liability management, and “immunization”, is costly when we hedge high-duration liabilities with low duration assets.

Chapter 0: Institutions and introductory details

63

## Page 65

Tutorials–some caveats

• A number of tutorials provide a few numerical examples relating to asset-liability management and hedging
— The calculations provided in these tutorials should be interpreted with some care ∗ The value of the zero coupon bonds changes over time ∗ In particular, this value changes over the horizon that we are designing scenarios for, even without any changes in the yield curve ∗ These eﬀects are studied in some cases in Mele (chap. 12)–would be useful although advanced material
• Duration hedging is a useful tool, although it has some limitations
— It is only a ﬁrst-order approximation to the price of bond. A conventional bond is typically strictly convex in the YTM. Therefore, for large changes in the YTM, we should update the duration-based hedging ratios.
— Re-adjustments are in order anyway, since ﬁxed income securities have duration that decreases over time.

Chapter 0: Institutions and introductory details

64

## Page 66

Negative convexity

• What happens when bond prices have “negative convexity”? In later chapters, we shall see that callable bonds and mortgage-backed-securities (MBS, henceforth) can be concave in the YTM! As we explained earlier, early repayments are likely to occur as the YTM decreases, which entails two inextricable consequences: (i) the price of the MBS “increases less” than a conventional bond price after a decline in the YTM, especially when the YTM is low; (ii) the duration of the MBS decreases as the YTM decreases.

• MBS may be responsible of ﬁnancial turmoil. The mechanism is well-known.

Institutions that hold MBS typically short conventional bonds for hedging purposes.

But the MBS duration increases as interest rates increase, due to negative convexity:

Duration 

=

−

convexity.

Therefore,

an

interest

rate

increase

can

lead

these

institutions

to go short additional conventional bonds, which worsens liquidity and leads to a

further interest rates increase, feeding a vicious circle. These properties are known

since at least Perli and Sack (2003), who estimated that in 2002 and 2003, this

mechanism may have ampliﬁed the volatility of the long-term US rates by a factor

between 15% and 30%.

Chapter 0: Institutions and introductory details

65

## Page 67

B Duration and interest rates for the negative convexity case–model examples taken from Chapter IV.

Stochastic duration Callable price volatility

10

0.14

9
0.12 8

7 0.1
6

5

0.08

4
0.06 3

2 0.04
1

0 0 0.02 0.04 0.06 0.08 0.1
Short term rate, r t

0.02 0

0.02 0.04 0.06 0.08 0.1
Short term rate, r t

Chapter 0: Institutions and introductory details

66

## Page 68

0.8 The yield curve and forward interest rates

A ﬁrst representation of bond prices

•  (   ) : price at  of a zero coupon bond expiring at  •  : discretely compounded interest rate for the time interval [   ], i.e.,

1

 (   ) =



(5)

1 + ( −  )  (   )

• The short-term rate process  is

 ≡ lim  (   ) 
 ↓

• Under conditions, there is no arbitrage if and only if

 ( 

)

=

E

 −

 






where E (·) is expectation under  conditional on information at time 

Chapter 0: Institutions and introductory details

67

## Page 69

• Easy to show the following. Given a set of dates {}=0, consider a ﬁxed coupon bond that pays oﬀ a coupon stream  at ,  = 1 · · ·  , and $1 at ;. Under conditions, its value is
  fcb ( ) =  ( ) +  ( ) 
=1

• A ﬂoating rate bond pays oﬀ coupons indexed to short-term rates,

1  = −1 (−1 ) =  (−1 ) − 1

where  ≡ +1 − , and where the second equality follows by Eq. (5).

Chapter 0: Institutions and introductory details

68

## Page 70

The yield curve

• The yield curve at time  for maturity at  is deﬁned as the curve (for ﬁxed )  −7 →  (  ) where the “spot rate”  (  ) is

1

 (  ) ≡ −

ln  (  ) 

 −

Forward rates

• In a forward rate agreement (FRA, henceforth), one party shall borrow from a counterparty in the future
• Forward rates are such that the value of a FRA equal to zero at origination •  (  ) : Forward rates at , regarding a future time-interval [ ]
— Possible to show that

 (  )

= 1 + ( −  )  (  ) 

(6)

 ( )

Clearly we have that

 (  ) =  ( ) 

Chapter 0: Institutions and introductory details

69

## Page 71

A second representation of bond prices

• We may express bond prices in terms of “instantaneous” forward rates. First, rearrange terms in Eq. (6) so as to obtain

 ( ) −  (  )

 (  ) = −



( −  ) ( )

• The instantaneous forward rate  (  ) is deﬁned as

 ln  (  )

 (  ) ≡ lim  (  ) = −



(7)

↓



It’s the marginal rate of return from committing a bond investment for an additional

instant

• Next, integrate Eq.

(7),

 ( )

=

−



ln

 () 

against

maturity

dates

,

use

 ( ) = 1, and obtain:

 (

)

=

−

 

 ()

(8)

• Eq. (8) suggests that we may model the yield curve by emphasizing the dynamics of forward rates

Chapter 0: Institutions and introductory details

70

## Page 72

Bootstrapping

* Appendix

• Extracting zeros is very important. — We need a “curve” of zeros, i.e. a function  → 7  ( ), in order to price coupon bonds consistently. — All available models rely on zero-coupon rates.
• The simple example in Eq. (3) can be problematic when the matrix of coupons payments is sparse in many “maturity slots”.

Bootstrapping proceeds as follows. Let  be the price of a bond paying oﬀ coupons at the sequence of dates 1 2 · · ·   and a principal of $1 at . Let  the zero maturing at . Then,

1.

The

equation

1

=

(11

+

1)

1

implies

that

we

can

extract

the

zero

1

as

follows,

1

=

1 1+11

.

2. Given the equation (22 + 1) 2 + 211 = 2, and the previously computed 1, we proceed to

3.

extract the zero 2 as follows, In general, we extract the zero

2 

= as

2−211 22+1

.

follows,  =

−=−11 
+1

.

4. The previous steps work if we have an ordered number of bonds and all of the maturity dates. Indeed,

the previous procedure boils down to the computation of the solution of Eq. (3). When some of the

maturity dates are not available, we replace the required coupon rate  at time  with a linear interpolation ˆ between the coupon −1 at time −1 and +1 at time +1, as follows,

ˆ

=

+1 −  +1 − −1

−1

+

 − −1 +1 − −1

+1

The eﬀects of the interpolation should be “visible” near the missing maturitites.

Chapter 0: Institutions and introductory details

71

## Page 73

A simple example on duration hedging: hedging zeros with zeros

Suppose that we hold one bond, a zero with maturity equal to 5 years. We want to hedge the risk of this bond through another bond, a zero with maturity equal to 1 year. Let us assume that the term-structure is ﬂat at 5%, discretely compounded. Then,

1

(ˆ1)

=

1 1+ˆ1

=

1 1+005

=

095238

2

(ˆ2)

=

1 (1+ˆ2)5

=

1 (1+005)5

=

078353

D (ˆ1)

=

DMac(ˆ1) 1+ˆ1

=

1 1+005

=

095238

D

(ˆ2)

=

DMac(ˆ2) 1+ˆ2

=

5 1+005

=

47619

1

=

D −
D

(ˆ2) 2 (ˆ1) 1

(ˆ2) (ˆ1)

2

=

47619 · 078353 −
095238 · 095238

·

1

=

−41135

That is, to hedge the 5Y zero, we need to short-sell approximately four 1Y zeros. The balance of this hedging position is,

1 (ˆ1) 1 + 2 (ˆ2) 2 = (−41135) · 095238 + 078353 = −31341

(9)

a quite ineﬃcient hedge.

The reason why this is ineﬃcient is clear. Hedging high maturity bonds with short maturity ones implies we should rebalance too often. Moreover, as time goes on, the sensitivity of the short-term bonds to changes in the YTM is very small (at the extreme, the price equals face value plus coupon, at maturity), compared to that of long-term bonds. Therefore, rebalancing becomes increasingly severe as time unfolds.

Chapter 0: Institutions and introductory details

72

## Page 74

We now study how the value of this portfolio changes after large changes in the YTM.

By the assumption that the initial term-structure is ﬂat at 5%, ˆ1 = ˆ2 = 5%. Moreover, by rearranging Eq. (9),
2 ( = 5%) = 41135 · 1 ( = 5%) − 31341 The left hand side of this equation is the price of the 5Y bond. The right hand side is the value of the “replicating” portfolio, which consists of (i) approximately 4 units of the 1Y bond, and (ii) the balance of the hedging position. Precisely, the right hand side is simply a net obligation: the value of the assets we need to purchase back (approximately 4 units of the 1Y bond), net of some cash we already have, which we can use to partially purchase these assets ($3.1341).

When  =6 5%, the previous relation can only approximately hold, 2 () ≈ 41135 · 1 () − 31341
Figure 3 below plots the left hand side and the right hand side of this relation.

Chapter 0: Institutions and introductory details

73

## Page 75

Bond price

1

0.95

0.9

0.85

0.8

0.75

0.7

0.65

0.6 0

0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09

0.1

YTM

Figure 3:

Solid line (top):

The

price

of

the

5Y

zero,

2 ()

=

1 (1+)5

,

where



is

the

YTM.

Dashed line (bottom): The value of the “replicating” portfolio consisting of (i) 41135 units

of the 1Y zero, and (ii) the balance of the hedging position, which is equal to −$31341, i.e.

41135

·

1 ()

−

31341,

where

1 ()

=

1 1+

is

the

1Y

zero

price.

Chapter 0: Institutions and introductory details

74

## Page 76

• What is going on? We are hedging the 5Y zero by selling approximately four 1Y zeros. In a neighborhood of  = 5%, the value of the “synthetic” 5Y zero we sold, 41135 · 1 () − 31341, behaves as 2 (). However, the 5Y zero displays more convexity than the “synthetic” bond. This larger convexity implies that:
— If the interest rates go down, the price of the 5Y zero bond we hold increases more than the value of the “synthetic” bond we sold. As a result, we make proﬁts.
— If the interest rates go up, the price of the 5Y zero bond we hold decreases less than the value of the “synthetic” bond we sold. As a result, we make proﬁts.
In all cases, we make proﬁts. Mathematically, proﬁts are equal to (2+ − 11+) − (2 − 11) ≡ ∆2 − 1∆1, where 2+ is the price of the 5Y bond, 1 is the price of the 1Y bond. Then, by convexity, 2 increases more than 11 when interest rates go down, and 2 decreases less than 11 when interest rates go up, or ∆2 − 1∆1 ≥ 0.
• However, this is not an arbitrage opportunity!
— The previous reasoning hinges on the assumption of a parallel shift in the term-structure of interest rates, that is ˆ1 = ˆ2, where ˆ1 = spot rate for 1 year, and ˆ2 = spot rate for 5 years.
— While parallel shifts in the term-structure seem empirically relevant, they are not the only shifts that are likely to occur, as we shall explain in Section I.8 below.

Chapter 0: Institutions and introductory details

75

## Page 77

Part I: Interest Rates

## Page 78

Contents
Chapter I: Empirical properties of interest rates Chapter II: Foundational issues on interest rate modeling Chapter III: Introduction to the industry modeling practice Chapter IV: Interest rate derivatives

## Page 79

Chapter I Empirical properties of interest rates

Chapter I - Empirical properties of interest rates

78

## Page 80

Table of contents

I.1 The yield curve and the business cycle

I.2 Additional stylized facts

I.3 Common factors aﬀecting the yield curve

* Appendix

Chapter I - Empirical properties of interest rates

79

## Page 81

I.1 The yield curve and the business cycle

• Yield curves do on average slope up • Why? Well ...
(i) on average, interest rates are expected to increase at maturities from one up to ten years (see, e.g., Figure 1 below)
(ii) investors are risk averse • However, yield curve may invert • Moreover, there is strong empirical evidence that inverted yield curves predict recessions
with a lead time of about one to two years. — See Figure 1 • Why? • Whilst trying to explain these facts, we’ll rely on the following

Expectation hypothesis: Forward rates equal expected future short-term rates

Chapter I - Empirical properties of interest rates

80

## Page 82

Term spread, with NBER recessions
5% 4% 3% 2% 1% 0% -1% -2% -3%
1960 1965 1970 1975 1980 1985 1990 1995 2000 2005

Figure 1. Time series of the term spread: diﬀerence between the 10 year yield minus the 3 month yield on U.S. Treasuries. Shaded areas mark recession periods as deﬁned by the National Bureau of Economic Research.

Chapter I - Empirical properties of interest rates

81

## Page 83

Comments

• Of course we observe recession episodes preceded by mild yield curve inversions • The strong empirical regularity is that the term spread sharply moves towards negative
territory – this occurred prior to most recession episodes so far — Note, it doesn’t matter whether this happens due to the short-term rate (going up)
or the long-term rate (going down) — The empirical regularity is: the term spread gets negative before recessions
Why do inverted yield curves precede recessions?

• Though to explain — Possibly due to both (i) monetary policy and the expectations about it, and (ii) the agents’ risk premiums for investing in long-term bonds

We discuss these two points below

Chapter I - Empirical properties of interest rates

82

## Page 84

Explanations

(i) The monetary channel :
— During expansions, monetary policy is restrictive in order to cool down the economy ∗ When the expansion is truly deep, short-term yields go up ∗ Yet during recessions the Fed keeps rates low to counter recessions
— When the expansion is deep market expectations may well be that the Fed will “soon” lower interest rates
— The expectation hypothesis now predicts that the slope of the yield curve should decrease
— (The expectation hypothesis may not hold empirically–bond markets command risk premiums. However, this may reinforce the previous conclusions.)
(ii) The risk premium channel:
— Very well-known that risk premiums are countercyclical – high during recessions and low during expansions. ∗ Conditional equity premium is countercyclical, and so is the long-bond premium. ∗ Long-term yields and equity expected returns are likely driven by the same state variables.1
1It has been known for a long time that long term bonds and the stock market are related. Remember the rule of thumb by which a stock market correction (a crash say) may be considered to be imminent when the spread 30 year bond yield minus the earning-price ratio is larger than 3%. This spread, which is usually around 1% or 2%–and on average, zero, once corrected for inﬂation–was indeed larger than 3% in 1987 and in 1997.

Chapter I - Empirical properties of interest rates

83

## Page 85

Let’s summarize

• Two forces — Countercyclical monetary policy =⇒ price of short-term bonds ↓ — Expectations about countercyclical monetary policy =⇒ price of long-term bonds ↑
• These two forces should occur at the height of an expansion. • Somehow trivially, our sample data include expansions that are followed by recessions
=⇒ the statistical facts we’re trying to explain — Of course we have formal models to show this

Chapter I - Empirical properties of interest rates

84

## Page 86

Criticism/caveats

1. Other explanations than the gaming between central banking and private investors’ expectations
— Financial intermediation and interest rate margins ∗ Adrian and Shin (2011) pointed out that interest rate margins2 help banks’ lending capacity ∗ Inverted yield curves lead to negative margins and, hence, a reduced credit supply ∗ Depresses aggregate demand, feeding expectations of an imminent recession3 and, hence, ∗ Negative term spreads ∗ . . . over a vicious circle
— Financial intermediation and expectations ∗ Banks observe signals of economic contractions ∗ They lend less, contributing to an upcoming contraction – similar as in the credit cycle mechanisms in macro-ﬁnance ∗ They also expect that (also due to their reduced lending) interest rates will decrease (due to monetary policy) · They demand more long-term bonds · Long-term yield decrease in the immediate term
2Interest margins ≈ interest on assets − interest on liabilities in the banks’ balance sheet. 3Consistent with the so called q-theory in macro-ﬁnance: lower proﬁts =⇒ lower investments. In our context, lower interest margins (proﬁts) =⇒ banks to lend less.

Chapter I - Empirical properties of interest rates

85

## Page 87

2. Interestingly, the empirical evidence on the yield curve inversions predictive power also covers periods prior to the creation of the Federal Reserve system (see, e.g., Gerlach and Stuart, 2018)
=⇒ May view creation of the Fed as a “Natural Experiment” =⇒ Additional forces may exist to explain the yield curve predictability ∗ Goes beyond the central banking vs market expectations gaming
3. Note that inverted yield curve may not always be due to the business cycle–then some of the empirical evidence we know occurred by chance
— In 2006 the yield curve inverted for diﬀerent reasons ∗ Strong demand for long-term bonds exerted by institutional investors · e.g., pension funds performing asset-liability management duties · Can’t quantify how this demand pressure contributed to the yield inversion of the time ∗ Note that the Fed had targeted higher interest rates right since 2006 to deal with inﬂationary pressures · (pressures also originating from Fed expansionary policy: the 2001 recession, the Twin Towers attacks and the 2003 corporate scandals) ∗ Open question is · Did the markets think the increased tightening was coinciding with the end of an expansion? ( =⇒ expected future interest rates ↓) · Inonically, we entered into the 2007 subprime turmoil (+ global ﬁnancial crisis) right after the Fed tightening

Chapter I - Empirical properties of interest rates

86

## Page 88

∗ Similarly, in 2000 the yield curve inverted right during the Treasury buyback programs · might have accounted for the inversion thru ↓ long-term bonds supply

4. Everything we know happened by pure coincidence

Chapter I - Empirical properties of interest rates

87

## Page 89

I.2 Additional stylized facts

• Yields are highly correlated — Three year yields correlated with four year — Four year yields correlated with ﬁve year — ... =⇒ This suggests some common factors drive the whole term structure of interest rates
• Yields are very persistent =⇒ implications for derivative pricing
• The term-structure of unconditional volatility is downward sloping

These properties are further discussed in this course

Chapter I - Empirical properties of interest rates

88

## Page 90

I.3 Common factors aﬀecting the yield curve

• Which systematic risks aﬀect the entire term-structure of interest rates? How many factors are needed to explain the variation of the yield curve? The standard “duration hedging” portfolio practice relies on the idea that most of the variation of the yield curve is successfully captured by a single factor that produces parallel shifts in the yield curve. How reliable is this idea, in practice?

• Litterman and Scheinkman (1991) demontrate that most of the variation (more than 95%) of the term-structure of interest rates can be attributed to the variation of three unobservable factors, which they label (i) a “level” factor, (ii) a “steepness” (or “slope”) factor, and (iii) a “curvature” factor. To disentangle these three factors, the authors make an unconditional analysis based on a ﬁxed-factor model.

• Succinctly, this methodology can be described as follows. Suppose that  yieldsto-maturity4 are generated by a linear factor structure with a ﬁxed number  of

factors,

 = ¯ +   +  

(1)

×1

×1

× ×1 ×1

where  is the vector of yields,  is the vector of (zero mean) common factors aﬀecting the yields, ¯ is the vector of unconditional expected yields,  is a vector of

idiosyncratic components of the yield generating process, and  is a matrix containing

the factor loadings.

4You may try to ﬁt the factor relation (1) on returns calculated from bond prices of  diﬀerent maturities. Would need to roll up bonds to account for time decay.

Chapter I - Empirical properties of interest rates

89

## Page 91

• Each row of  contains the factor loadings for all the common factors aﬀecting a

given yield, i.e., the sensitivities of a given yield to a unit change in the factors

• Each column of  contains the term-structure of factor loadings, i.e., the sensitivity

of all yields to a unit change of a given factor

• The appendix provides a few methodological details on factor and principal components

analysis.

• Example of Eq. (1), for  = 3:

 

...1

 =

¯... 1

 +

...11

...12







...13



1 2

+

1...





¯

1 2 3

3







• Example #1. Factor loadings regarding the ﬁrst factor are  ...11 . Each element

1

•

tells you Example

the sensitivity #2. The ﬁrst

of each asset returns return satisﬁes: 1

to =

a unit ¯1 +

 cha3n=g1ein1the1+st

factor. 1.

The empirical evidence

• Striking. Litterman and Scheinkman (1991) result hold across a number of countries and sample periods
• Will now illustrate these results relying on Principal Component Analysis.

Chapter I - Empirical properties of interest rates

90

## Page 92

Factor loadings (PCA) for the U.S. yield curve
0.6

0.4

0.2

level
0
slope

-0.2

curvature

-0.4 0
6

5
Level

10

15

20

Maturity (years)

Slope

6

6

25

30

Curvature

5.5

5.5

5.5

5

5

5

4.5

4.5

4.5

4

4

4

3.5

3.5

3.5

3

0

10

20

30

Maturity (years)

3

0

10

20

30

Maturity (years)

3

0

10

20

30

Maturity (years)

Figure 2. Changes in the term-structure of interest rates generated by changes in the “level”, “slope” and “curvature” factors.

Chapter I - Empirical properties of interest rates

91

## Page 93

Figure 2 visualizes the eﬀects that the three factors have on the movements of the term-structure of interest rates.

(i) The ﬁrst factor is called a “level” factor as its changes lead to parallel shifts in the term-structure of interes rates. Thus, this “level” factor produces essentially the same eﬀects on the term-structure as those underlying the “duration hedging” portfolio practice. This factor explains approximately 80% of the total variation of the yield curve.
(ii) The second factor is called a “steepness” factor as its variations induce changes in the slope of the term-structure of interest rates. After a shock in this steepness factor, the short-end and the long-end of the yield curve move into opposite directions. The movements of this factor explain approximately 15% of the total variation of the yield curve.
(iii) The third factor is called a “curvature” factor as its changes lead to changes in the curvature of the yield curve. That is, following a shock in the curvature factor, the middle of the yield curve and both the short-end and the long-end of the yield curve move in opposite directions. This curvature factor accounts for approximately 5% of the total variation of the yield curve.
• Understanding the origins of these three factors is still a challenge to ﬁnancial economists and macroeconomists. For example, macroeconomists explain that central banks aﬀect the short-end of the yield curve, e.g., in the U.S., by inducing variations in the Federal Funds rate. However, Fed decisions rest on the current macroeconomic

Chapter I - Empirical properties of interest rates

92

## Page 94

conditions. Therefore, we should expect that the short-end of the yield-curve is related to the development of macroeconomic factors.

• Instead, the development of the long-end of the yield curve should largely depend on the market average expectation and risk-aversion surrounding future interest rates and economic conditions. Financial economists, then, should expect to see the long-end of the yield curve as driven by expectations of future economic activity, and by risk-aversion.

Indeed, it is known since at least Ang and Piazzesi (2003) that macroeconomic factors such as inﬂation and real economic activity are able to explain movements at the short-end and the middle of the yield curve. However, they show that the long-end of the yield curve is driven by unobservable factors. It is not clear, however, whether such unobservable factors are driven by time-varying risk-aversion or changing expectations.

• The compelling lesson for practitioners is that reduced-form models with only one factor are unlikely to perform well.

Chapter I - Empirical properties of interest rates

93

## Page 95

* Appendix

Maximum likelihood estimation of Eq. (1)

• Suppose that in Eq. (1),  ∼  (0 ), and that  ∼  (0 Ψ), where Ψ is diagonal. Then,



∼



¯

 Σ

,

where

Σ

=

>

+

Ψ

The assumptions that  ∼  (0 ) and that Ψ is diagonal are necessary to identify the model, but not suﬃcient. Indeed, any orthogonal rotation of the factors yields a new set of factors which also satisﬁes Eq. (1). Precisely, let  be an orthonormal matrix. Then,
( ) ( )> =   >> = >

Hence, the factor loadings  and  have the same ability to generate the matrix Σ.

• To obtain a unique solution, one needs to impose extra constraints on . For example, Jo¨reskog (1967) develops a maximum likelihood approach in which the log-likelihood function is,

log-likelihood

=

1 −

 log

|Σ|

+

Tr

Σ−1



2

where  is the sample covariance matrix of , and the constraint is that >Ψ be diagonal with
elements arranged in descending order. The algorithm is:
(i) For a given Ψ, maximize the log-likelihood with respect to , under the constraint that >Ψ be diagonal with elements arranged in descending order, thereby obtaining ˆ.
(ii) Given ˆ, maximize the log-likelihood with respect to Ψ, thereby obtaining Ψˆ , which is fed back into
step (i), etc.

Chapter I - Empirical properties of interest rates

94

## Page 96

Knez, Litterman and Scheinkman (1994) describe this approach in their paper. Note that the
identiﬁcation device they describe at p. 1869 (Step 3) roughly corresponds to the requirement that >Ψ be diagonal with elements arranged in descending order. Such a constraint is clearly related
to principal component analysis.

Methodological details on principal components analysis
Estimating the model in Eq. (1) leads to econometric challenges, mainly because the vector of factors  is unobservable. However, there exists a simple technique, known as principal components analysis (PCA, henceforth), which leads to empirical results qualitatively similar to those that hold for the general model in Eq. (1). We discuss these empirical results in the next subsection. We now describe the main methodological issues arising within PCA.

• The main idea underlying PCA is to transform the original  correlated variables  into a set of new

uncorrelated variables, the principal components. These principal components are linear combinations

of the original variables, and are arranged in order of decreased importance: the ﬁrst principal component

accounts for as much as possible of the variation in the original data, etc. We are are looking for 

linear combinations of the demeaned excess returns,



=

>

 

−

¯



 = 1 · · ·  

(2)

such that, for  vectors > of dimension 1 × , (i) the new variables  are uncorrelated, and (ii) their

variances are arranged in decreasing order.

• The logic underlying PCA is to ascertain whether a few components of  = [1 · · · ]> account for

the we

bulk of the variability in the original can write Eq. (2) in matrix format, 

d=ata. >Let−>

=¯[or1>, b·y·

· >] be inverting,

a



×



matrix

such

that

 − ¯ = >−1

(3)

Chapter I - Empirical properties of interest rates

95

## Page 97

• Next, suppose that the vector  () = [1 · · · ]> accounts for most of the variability of the original data,5 and let >() denote a  ×  matrix extracted from the matrix >−1 through the ﬁrst  rows of >−1. Since the components of  () are uncorrelated and they are deemed largely responsible for

the variability of the original data, it is natural to “disregard” the last  −  components of  in Eq.

(3),

 − ¯ ≈ >()  ()

×1

× ×1

If the vector  () really accounts for most of the movements of , the previous approximation to Eq.

(3) should be fairly good.

• Let us make more precise what the concept of variability is in the context of PCA. Suppose that the variance-covariance matrix of the returns, Σ (say), has  distinct eigenvalues, ordered from the highest to the lowest, as follows: 1  · · ·  . Then, the vector  in Eq. (2) is the eigenvector corresponding to the -th eigenvalue. Moreover,

 () =   = 1 · · ·  

Finally, we have that

RPCA

=

 =1
=1

 

() ()

=

 =1
=1

  

(4)

(A proof of the previous formulae is available below.) It is in the sense of Eq. (4) that in the context

of PCA, we say that the ﬁrst  principal components account for RPCA% of the total variation of the data.

• So principal component analysis transforms the original data into a set of uncorrelated variables, the principal components, with variances arranged in descending order.

5There are no rigorous criteria to say what “most of the variability” means in this context. Instead, a likelihood-ratio test is most informative in the context of the estimation of Eq. (1) by means of the methods explained in the appendix to this chapter.

Chapter I - Empirical properties of interest rates

96

## Page 98

• We now prove the previous formuale. Consider the following program,

max [ (1)]
1

s.t.

1>1

=

1

where  (1) = 1>Σ1, and the constraint is an identiﬁcation constraint. The ﬁrst order conditions lead to,
(Σ − ) 1 = 0
where  is a Lagrange multiplier. The previous condition tells us that  must be one eigenvalue
of the matrix Σ, and that 1 must be the corresponding eigenvector. Moreover, we have  (1) = 1>Σ1 =  which is clearly maximized by the largest eigenvalue. Suppose that the eigenvalues of Σ are distinct, and let us arrange them in descending order, i.e. 1  · · ·  . Then,

 (1) = 1

Therefore,

the

ﬁrst

principal

component

is

1

=

1>

 

−

¯,

where

1

is

the

eigenvector

corresponding to the largest eigenvalue, 1.

• Next, consider the second principal component. The program is, now,

max [ (2)]
2

s.t. 2>2

= 1 and 2>1

= 0

where  (2) = 2>Σ2. The ﬁrst constraint, 2>2 = 1, is the usual identiﬁcation constraint. The second constraint, 2>1 = 0, is needed to ensure that 1 and 2 are orthogonal, i.e.  (12) = 0. The ﬁrst order conditions for this problem are,

0 = 2Σ2 − 22 − 1

where  is the Lagrange multiplier associated with the ﬁrst constraint, and  is the Lagrange multiplier

Chapter I - Empirical properties of interest rates

97

## Page 99

associated with the second constraint. By pre-multiplying the ﬁrst order conditions by 1>,

0 = 21>Σ2 − 

where we have used the two constraints 1>2 = 0 and 1>1 = 1. Post-multiplying the previous expression by 1>, one obtains, 0 = 1>Σ21> − 1> = −1>, where the last equality follows by 1>2 = 0. Hence,  = 0. So the ﬁrst order conditions can be rewritten as,

(Σ − ) 2 = 0

The solution is now 2, and 2 is the eigenvector not choose 1 as this choice would imply that 2 =

co1>rrespon−din¯g,toimp2ly.in(gIntdheaetd,

this time we can (12) =6 0.) It

follows that  (2) = 2.

• In general, we have,

 () =   = 1 · · ·  

Let Λ be the diagonal matrix with the eigenvalues  on the diagonal. By the spectral decomposition of Σ, Σ = Λ>, and by the orthonormality of , > = , we have that >Σ = Λ and, hence,


=1



()

=

Tr

(Σ)

=

Tr

 Σ



>

=

Tr

 

>Σ



=

Tr

(Λ)



Chapter I - Empirical properties of interest rates

98

## Page 100

Chapter II Foundational issues on interest rate modeling

## Page 101

II.1 Trees

Table of contents

II.2 Tree representation of the short-term rate

II.3 Tree pricing

II.4 Evaluation in continuous time

II.5 Multifactor models

II.6 Aﬃne models

* Appendix

Chapter II - Foundational issues on interest rate modeling

100

## Page 102

II.1 Trees

• The classical ideas underlying option evaluation through binomial trees can be applied to pricing ﬁxed income instruments, although this requires revising quite a few methodological details.
• General ideas
— Create a probabilistic representation of how the price develops over time using a tree-information structure
— For example, at the time of evaluation, we observe the state. In the next period, there can be two mutually exclusive states of the world: ∗ The state “up”, occurring with probability , and the state “down”, occurring with probability 1 − . ∗ After two periods, there can be three mutually exclusive states of the world, as in the following diagram. We label the tree in this diagram a “recombining” tree, to emphasize that the “up & down” and the “down & up” nodes are the same.

Chapter II - Foundational issues on interest rate modeling

101

## Page 103

"up-up" "up"

Today

"up-down" "down-up"

"down"

First period

"down-down"
Second period

• This diagram can be used to price options written on stocks. The stock price unfolds through the branches of the tree. Then, we ﬁgure out the no-arbitrage movements of the option price along the tree.
• Suppose we wish to price an option written on a zero, a 3 Year zero say. Can we apply the same methodology to price the option?
— No. — The reason is that we cannot exogenously “track” the movements of the prices of
the zero, as in the case of the stock price. Instead, after one year, the 3 Year zero becomes a 2 Year zero, i.e. a quite diﬀerent asset.

Chapter II - Foundational issues on interest rate modeling

102

## Page 104

• The trick, here, is to model the movements of the yield curve. There are two approaches.
— In the ﬁrst approach, we model the dynamics of the short-term rate, deﬁned as the interest rate on a loan with maturity equal to the time intervals in the tree. The resulting model, which we call model of the short-term rate, has implications in terms of the movements of the entire term-structure. ∗ This approach gives rise to evaluation formulae in which the current prices of the zeros predicted by the model are not necessarily equal to the market prices. We develop this approach mostly in this chapter.
— In a second approach, called the no-arbitrage, or calibration, approach, we model the dynamics of the entire term-structure. ∗ This approach gives rise to option evaluation formulae in which the current prices of the zeros predicted by the model are equal to the market prices. We develop this approach mostly in the next chapter — and in the tutorials.

Chapter II - Foundational issues on interest rate modeling

103

## Page 105

II.2 Tree representation of the short-term rate
Recursive evaluation

• Consider a two-period and two-state tree in which the current short-term rate is . The

development of the short-term rate is uncertain. That is, the future short-term rate, ˜, is random, and can take two values: either + with probability , or − with probability 1 − . We assume that +  −. We emphasize  is the physical probability.

+ ⇒  +   %



1− &

−

⇒



−

 

• Suppose, also, that — Two zeros with distinct maturities are available for trading — A money market accounting technology is also available (MMA, in the sequel). Investing $1 in the MMA generates $1·(1 + ) in the second period.

The objective

• We aim to derive an evaluation formula for the zero based on the previous probabilistic model for the short-term rate dynamics.

Chapter II - Foundational issues on interest rate modeling

104

## Page 106

The idea

• The general idea is to build up a portfolio that contains one zero and the MMA. — We shall make sure the value of this portfolio in the second period replicate the value of the zero we wish to price. — By no-arbitrage, then, the value of the portfolio in the ﬁrst period must equal the value of the zero we wish to price, and we shall be done.
• The appendix develops the arguments, and shows that in the absence of arbitrage, there is a constant , such that the following relation holds true:

∆ (˜  )

 [ (˜  )]−(1 + )  (  ) = 

∆˜

· Vol 

(˜

−

)· 

=

 
unit risk premium

(1)

= volatility of the price

where Vol(˜ − ) = + − −, and  [ (˜  )] denotes the expectation of the

bond price under the probability .

• Eq. (1) is an “APT” (APT: “Arbitrage Pricing Theory”) relation. It says that the

excess return on the zero equals the volatility of its price multiplied by the unit price of

risk.

• We call the term,

∆ (˜  ) · Vol (˜ − )
∆˜

“price volatility” because it measures the amplitude of the price variation due to changes

in

the

short-term

rate

in

the

future,

∆ (˜ ∆˜

)

,

i.e.

the “price-sensitivity”, where this

price sensitivity is normalized by the volatility of the short-term rate, Vol(˜ − ).

Chapter II - Foundational issues on interest rate modeling

105

## Page 107

• Eq. (1), or equivalently, Eq. (17) in the Appendix, can now be cast in a format that we can use to make it more “operational”. After rearranging terms, we obtain:



(

)

=

(

−

) 

+

 

+

[1

−

(

−

)]



−

 

=



[

(˜

 )]

1+

1+

(2) where  ≡  −  is the risk-neutral probability.

A few considerations

• We “expect” that   0 because bond prices are decreasing in the short-term rate here.
• Then,  ≡  −   .1 Hence,
— The risk-neutral probability of an upward movement of the short-term rate, , is higher than the true probability, .
— An investor who goes long a bond, is concerned by an increase of the short-term rate in the future and, hence, “corrects” the true probability  by assigning a higher risk-adjusted probability to the “upward” state.

1To be able to interpret  as a probability, we must have that (i)  ≡  −   0 ⇔ −  − and  ≡  −   1 ⇔ −  1 − . That is, − ∈ (− 1 − )

Chapter II - Foundational issues on interest rate modeling

106

## Page 108

One example

• Assume the current short-term rate equals 10%. We know that with (physical ) probability , the short-term rate as of the next year will increase by 2 percentage points, and with probability 1 − , it will decrease by 2 percentage points. Finally, with the same probability , the short-term rate prevaling from the next year to two years time, will increase by 2 further percentage points from its previous value in one year time. Suppose that the probability of an upward movement is 20% and that the the absolute value of the Sharpe ratio is 30%.

Risk-neutral probability

• These data suﬃce to provide an estimate of the risk-neutral probability of an upward movement of the short-term rate. We simply use the formula,  =  − , and obtain  = 20% − (−30%) = 50%.

Chapter II - Foundational issues on interest rate modeling

107

## Page 109

Pricing zeros

• Next, we can price, say, a zero maturing in two years. We can set up the following tree:

1 Year

2 Years

Chapter II - Foundational issues on interest rate modeling

108

## Page 110

• We can use Eq. (2) to ﬁll-in each node of the tree. We start from the end of the tree,

where the price of the two years zero is $1, and then use Eq. (2) to ﬁll every node, as

illustrated below.

1 Year

2 Years

• The price of the zero, in one year, is simply one divided by the interest rate (or, discount) factor relevant at the beginning of the year, next year. The price we are looking for is obtained by applying Eq. (2) yielding,

 [ (˜ 2)] =  (+ 2) + (1 − )  (− 2)

1+

1+

=

1 2

(08928)

+

1 2

(09259)

110

= 08267

Chapter II - Foundational issues on interest rate modeling

109

## Page 111

II.3 Tree pricing

• We can simply generalize the tree to a multiperiod case • We use Eq. (2) to evaluate zeros at all nodes of the tree and maturities.
— Given , which can be estimated once we estimate  and , we use recursively Eq. (2).
• Then, we may price options on zeros • Weakness of the approach: the initial term structure is predicted with error!
— Would need to introduce the notion of implied binomial trees

Tutorials

• A number of tutorials on implied binomial trees and many concrete numerical examples

Chapter II - Foundational issues on interest rate modeling

110

## Page 112

II.4 Evaluation in continuous time

No arbitrage

• Recall Eq. (1)

∆ (˜  )

 [ (˜  )] − (1 + )  (  ) = 

∆˜

· Vol (˜ − ) ·





 
= unit risk premium

= volatility of the price

• In this section, we show that the continuous time counterpart to this equation is:

 [ (  − )] −  (  − ) = 

 (  − )



 

·



() 

·

unit

() 
risk premium

volatility of the price

where  () is the instantaneous volatility of the short-term rate, deﬁned in a moment.

Chapter II - Foundational issues on interest rate modeling

111

## Page 113

• Assumption. The short term rate ( )≥0 is exogenously given, and is solution to a diﬀusion process

 =  (   )  +  (   )    ∈ (  ]

where  is a standard BM under  ; and  and  are drift and diﬀusion coeﬃcients of this diﬀusion

• Under regularity conditions, the price of a zero coupon bond is



(





)

=

E

 −

 






• Please note that  only depends on  as short-term rate is a Markov process • What can we say about the two functions  and ? Should possibly lead to
— a solution fast to compute in practice — empirically accurate model predictions • Well-known models solved in closed form are the “aﬃne” models reviewed below • Note that the model in this chapter determines the yield curve and it cannot then exactly ﬁt it.

Chapter II - Foundational issues on interest rate modeling

112

## Page 114

The bond pricing equation

• Denote with  ≡  (  ) the price of zero coupon bond at time- and expiring at .
• Assume (we’ll verify this below) that bond prices are solutions to

 

=



+



(3)

where  is a standard BM under  ; and  and  are drift and diﬀusion coeﬃcients of this diﬀusion

• Now,  and  are not given — They are endogenous–determined as a part of the equilibrium

• We’ll show that there exists some  such that the price system in (3) is arbitrage-free iﬀ

 =  + 

(4)

• Easy to interpret. Replacing (4) into (3) leaves

 

=

(

+

) 

+



— The expected growth rate of  equals the short-term (= safe) rate plus a term-premium equal to 

Chapter II - Foundational issues on interest rate modeling

113

## Page 115

• Derive (4) in the simple case  = 1 • Let  denote the value of a self-ﬁnanced portfolio in two bonds and a money market
account. We have:

 = (1(1 − ) + 2(2 − ) +  )  + (11 + 22) 

where  is wealth invested in a bond maturing at  — if  denotes the units of bonds in the portfolio,  = . • The portfolio has no volatility when

1

=

−

2 1

2

Replacing this into  leaves



=

 −

1

−



1

 2 + 

(2

−


) 2 

+



 

≡

• Note that we can always choose 2 in a way that    
— Just set sign (2) = sign () — It’s an arbitrage!

Chapter II - Foundational issues on interest rate modeling

114

## Page 116

• We rule out arbitrage with  = 0, or

1

−



=

2

−

 

1

2

That is, the Sharpe ratio for any two bonds must equal some , say, and Eq. (4) follows.

• Note that  is independent of the maturities 1 or 2

— It’s natural:  is the unit price of risk for ﬂuctuations in  • Next, determine  and . • Use Itoˆ’s lemma

— Notation:  (    ) is the price at  of a bond maturing at  when the state at  is .
— By Itoˆ’s lemma,



=

 

+ 

+

212 

+ 

(subscripts denote partial derivatives) — Comparing this with Eq. (3), and identifying drifts and diﬀusion terms



=

 

+ 

+

1 2

2

and  = 

Chapter II - Foundational issues on interest rate modeling

115

## Page 117

— Finally, replace these into Eq. (4). The result is that  satisﬁes the following “PDE” (PDE: “Partial Diﬀerential Equation”)

 

+ 

+

1 2

2

=



+ 

(5)

with the boundary condition  (   ) = 1, holding for all 

Chapter II - Foundational issues on interest rate modeling

116

## Page 118

Some more interpretation

Consider again Eq. (1), which we report here, for convenience,

∆ (˜  − )

 [ (˜  − )] − (1 + )  (  − ) = 

∆˜



·

Vol

(˜

−

) 

·

unit

 risk premium

volatility of the price

If we consider small changes in , we can re-write the previous equation as,

 [ (  − )] −  (  − ) = 

 (  − )



 

·



() 

·

unit

 ()
risk premium

(6)

volatility of the price

We know that by Itoˆ’s lemma,

 (  − )

 (  − )

1 2 (  − )

 [ (  )] =

 + 



 () + 2

2

 ()

=

 (  

−

) 

+

 (  

−

) 

()



+

1 2

2 (  2

−

) 

()2



By replacing this expression for  [ (  )] into Eq. (6), we obtain the following PDE

  

 (  

−

)

+

 (  

−

) 

()

+

1 2

2 (  2

−

) 

()2

=



( 

−

)

+

 (  

−

)

·



()

·

 ()

 ( 0) = 1

where the second condition,  ( 0) = 1, is the obvious boundary condition.

Chapter II - Foundational issues on interest rate modeling

117

## Page 119

A few models of the short-term rate

• The ﬁrst continuous time model for the short-term rate was introduced by Merton

(1973), and then generalized by Vasicek (1977), who assumed that the short-term rate

is solution to,

 =  (¯ −  )  +  

(7)

where  is a Brownian motion, and ¯,  and  are positive constants. (In Merton (1973), the drift was  for some constant   0.)

— The important feature underlying Eq. (7) relates to mean-reversion. If   0, then, the short-term rate is expected to increase (resp. decrease) if it lies below (resp. above) its long-term value ¯.
— It can be shown that  is conditionally normally distributed. Its marginal density is also normal, with expectation equal to ¯ and variance equal to 22.
— The model suﬀers from two main drawbacks. ∗ The ﬁrst drawback is that the short-term rate is Gaussian and, hence, can take on negative values with positive probability. ∗ The second drawback is that the short-term rate diﬀusion is independent of the level of the short-term rate. This seems to be conterfactual as the short-term rate changes become more and more volatile as the level of the short-term rate increases. In the empirical literature, this phenomenon is usually referred to as the level-eﬀect.

Chapter II - Foundational issues on interest rate modeling

118

## Page 120

• The model proposed by Cox, Ingersoll and Ross (1985) (CIR, henceforth) addresses these two drawbacks at once, as it assumes that the short-term rate is solution to,
√  =  (¯ −  )  +    

The CIR model is also referred to as “square-root” process to emphasize that the diﬀusion function is proportional to the square-root of . This feature makes the model address the level-eﬀect phenomenon. Moreover, this property prevents  from taking negative values. Intuitively, when  wanders just above zero, it is pulled back to the stricly positive region at a strength of the order  = ¯ .

Chapter II - Foundational issues on interest rate modeling

119

## Page 121

Solutions

• Both Vasicek and CIR models admit a closed form solution, under the following conditions on the unit risk premiums — In the Vasicek mod√el,  () = , a constant. — In CIR,  () =  , where  is a constant.
• In particular, the solution to the Vasicek model is,

 (  − ) = ( −)−( −)·

(8)

where the two functions  and  are reported below

 ( − )

=

1

 1

−

 −( −)



 ( − )

=

12 



(

 − )2 − (¯ − )



 (

− ) 

2



• The CIR model also admits a solution with the same functional form as (8), but with diﬀerent expressions for  and 

Chapter II - Foundational issues on interest rate modeling

120

## Page 122

• How do we solve them? Consider the Vasicek model. Assume  is a constant

• Replacing  and () =  (¯ − ) and () =  into Eq. (5), and denoting

∗

≡

¯

−

 

,

we

ﬁnd

that

the

bond

price

is

the

solution

to

the

following

PDE

0

=

 

+



∗

−

 



+

1 2

2

− 

(9)

with the usual boundary condition • Guess that the solution is indeed (8). Replace the partial derivatives of  into (9) and
obtain 1 ( ) + 2 ( )  = 0, where for all  ,

1

( )

≡

1

( 

)

−

∗

( 

)

+

122 2

( 



)

=

0

2 ( ) ≡  (   ) − 1 (   ) − 1 = 0

These are two ordinary diﬀerential equations subject to  (  ) = 0 and  (  ) = 0. Solutions are

 (   )

=

(

(   )

−

(

−

 )) ∞

−

2 2 (   ) 4

 (   )

=

1





1 − −( −) 



where

∞

=

∗

−

1 2



 

2.

Chapter II - Foundational issues on interest rate modeling

121

## Page 123

• The yield curve is given by

1

 (  )  (  )

 (  − ) = −

ln  (  − ) = −

+

 (10)

 −

 −

 −

• Easy to see that the limit of  (   ) for large  is ∞. We usually refer to ∞ as the “asymptotic” spot rate. Below is an example of the yield curve, obtained with  = 02, ¯ = 6%,  = 003,  = −0015. (With these parameter values, ∞ = 510%)

Yield curve predicted by Vasicek model

0.07 0.065
0.06 0.055
0.05 0.045
0.04 0.035
0.03 0

5

10

15

20

25

30

Time to maturity (years)

Chapter II - Foundational issues on interest rate modeling

122

## Page 124

One application example

• We can do a number of things once we have solved for a model
• Consider Vasicek model. You may be asked, “What is the most likely evolution of the
yield curve in the next three monts? ” — Consider  0  in Eq. (10): the yield curve at time-0 — You may wantto assess what the yield curve will look like at some future time-1,
i.e.,  1  — We know  is conditionally normally distributed. Eq. (10) then suggests that, for
each  ,  1  is also conditionally normally distributed with mean



 

 1

 

 0

=

 ( ) −


+

 ( 

) 

 1 

 0

and variance





 

 1

 

 0

=

 ( )2 



1

 0

— You may plot conﬁdence intervals for your forecasts2

2We know that



 1 

 0

=

¯

+

−(1−0)

 0

−

 ¯

;



 1 

 0

=

2 2

 1

−

 −2(1−0)

Chapter II - Foundational issues on interest rate modeling

123

## Page 125

• Assume  = 003 and forecast horizon equal to 3 months. Dashed line: current yield curve. Solid line: Expected yield curve. Shaded areas comprise ∓ one standard deviation

• When no closed-form solutions exist for the interest rate transition density, you may proceed through simulations

Chapter II - Foundational issues on interest rate modeling

124

## Page 126

II.5 Multifactor models

• The empirical evidence reviewed in Chapter I suggests that one-factor models cannot explain the entire variation of the yield curve. Factor analysis suggests we need at least three factors
• We succinctly review the advances made in the literature to address these important empirical issues.

Chapter II - Foundational issues on interest rate modeling

125

## Page 127

Stochastic volatility–Motivation

• In the CIR model, the instantaneous short-term rate volatility is stochastic–depends on the short-term rate level, which is obviously stochastic
• However, we now review strong empirical evidence suggesting that the short-term rate volatility depends on some additional factors
• In particular, it seems that interest rate volatility is ﬂat against the level of rates–with two notable exceptions
1. The “Monetary Experiment” of the early ’80s–when the Fed target was money supply (not interest rates). Caused by two factors ∗ high volatility of money demand mechanically translated to high interest rate volatility ∗ monetary base was kept deliberately low (ﬁght against inﬂation) ∗ Whence, interest rate volatility and interest rates were both very high ∗ One additional reason for the high nominal rates at the time might link to a compensation for high inﬂation volatility–not only high inﬂation.
2. Rates close to the “zero lower bound.” When rates are small and their volatility is compressed, interest rate vol seems to be increasing in the rate levels ∗ Natural: if the Fed is credible in maintaining low rates (e.g., during QE), interest rate vol remains low ∗ Interest rate vol (when low) may be read as a measure of monetary policy credibility

Chapter II - Foundational issues on interest rate modeling

126

## Page 128

• Interest rates and interest rate volatility

3 month TB rate

15

10

5

0 1960 1965 1970 1975 1980 1985 1990 1995 2000 2005

600 500 400 300 200 100
0 1960

1965

1970

1975

1980

1985

1990

1995

2000

2005

BP volatility

Chapter II - Foundational issues on interest rate modeling

127

## Page 129

• Level eﬀect?

Basis Point volatility

Sample size: 1957:01 - 2008:12 600

500

400

300

200

100

0

0

5

10

15

20

Short-term rate

Sample size: 1957:01 - 2008:12 150

100

50

0

0

5

10

15

20

Short-term rate

Log volatility

Basis Point volatility

Sample size: 1990:01 - 2008:12 200

150

100

50

0

0

2

4

6

8

Short-term rate

Sample size: 1990:01 - 2008:12 120

100

80

60

40

20

0

0

2

4

6

8

Short-term rate

Log volatility

Chapter II - Foundational issues on interest rate modeling

128

## Page 130

• Intriguing empirical property: the term spread may anticipate interest rate volatility — on the one hand, the term spread anticipates NBER dated recessions — on the other hand, interest rate vol increases during recessions – Fed on average decreases rates more rapidly than it increases them

Basis Point volatility Basis Point volatility

Sample size: 1957:01 - 2008:12 600

500

400

300

200

100

0

-2

0

2

4

Term spread (as of 12 months earlier)

Sample size: 1990:01 - 2008:12 180

160

140

120

100

80

60

40

20

0

-1

0

1

2

3

4

Term spread (as of 12 months earlier)

Chapter II - Foundational issues on interest rate modeling

129

## Page 131

Stochastic volatility–Modeling

• A natural extension of the CIR model is one in which the instantaneous volatility of the short-term rate depends on (i) the level of the short-term rate, similarly as in the CIR model, and (ii) some additional random component
— The additional random component is the “stochastic volatility” component of the short-term rate
— It is the term-structure counterpart to the stochastic volatility extension of the Black and Scholes (1973) model.
• Fong and Vasicek (1991) developed the ﬁrst model along these lines:

 

= =

 (¯ −  )   (¯ −  ) 

+ √√ 1 +   2

(11)

where , ¯, , ¯ and  are constants, and [1 2] is a vector Brownian motion. • To obtain a closed-form solution, Fong and Vasicek set  = 0. They also make
assumptions regarding risk aversion corrections

—

They rate,

assume , and

that the

unit risk-premiums for the stochastic ﬂuctuations of short-term rate volatility, , are both proportional

tthoe√short-term

— They found a closed-form solution for the bond price  (   − ).

• Longstaﬀ and Schwartz (1992) propose another model of the short-term rate in which

the volatility of the short-term rate is stochastic. The remarkable feature of their

Chapter II - Foundational issues on interest rate modeling

130

## Page 132

model is that it is a general equilibrium model. Naturally, the Longstaﬀ-Schwartz

model predicts, as the Fong-Vasicek model, that the price of the zero is a function of both the short-term rate and its instantaneous volatility.

• Note, then, the important feature of these models. The bond price,  (   − ) and, hence, the yield curve,

 (   − ) ≡ − ( − )−1 ln  (   − ) 

depends on the level of the short-term rate, , and one additional factor, the instantaneous variance of the short-term rate, . Hence, these models predict that we now have two factors that help explain the whole yield curve,  (   − ).
• Some issues:
— What is the relation between the volatility of the short-term rate and the term-structure of interest rates?
— Does this volatility help “track” one of the factors driving the variations of the yield curve?

Chapter II - Foundational issues on interest rate modeling

131

## Page 133

• How can we use these results to rationalize the factor analysis reviewed in Chapter I?

Factor loadings (PCA) for the U.S. yield curve
0.6

0.4

0.2

0

level

slope

-0.2

curvature

-0.4 0
6

5
Level

10

15

20

Maturity (years)

Slope

6

6

25

30

Curvature

5.5

5.5

5.5

5

5

5

4.5

4.5

4.5

4

4

4

3.5

3.5

3.5

3

0

10

20

30

Maturity (years)

3

0

10

20

30

Maturity (years)

3

0

10

20

30

Maturity (years)

Chapter II - Foundational issues on interest rate modeling

132

## Page 134

• Stochastic volatility factor–implications
— The short-end of yield curve is substantially unaﬀected by movements of the volatility, as lim →  (   − ) = , for all 
— Furthermore, these models predict that lim →∞  (   − ) = ¯, where ¯ is a constant–hence, independent of 
=⇒ It follows that movements in the short-term rate vol may only aﬀect the middle of the yield curve.
— If the risk premium for interest rate risk is negative and large, an increase in  may aﬀect the yield curve in a way qualitatively similar to that in the previous “Curvature” panel–would thus roughly mimic a “curvature” factor

Chapter II - Foundational issues on interest rate modeling

133

## Page 135

• Examples Yield curves predicted by stochastic volatility model (11)

—

Parameter values:   = 0025,  = 0.

= 0,  = Risk aversion

010, ¯ = correction:

005,  =

−5√=0 ,20, ¯==02√022,,

—

1 = Small

−5, vol:

√2 ==0001;

medium

vol:

√

= 002; high vol:

√

= 003

Yield curve

0.045 0.04
0.035 0.03
0.025 0.02 0

high vol medium vol small vol

5

10

15

20

25

30

Time-to-maturity

Chapter II - Foundational issues on interest rate modeling

134

## Page 136

• Review/extend the forecasting exercise re: the one-factor “most likely evolution of the yield curve in the next three months” to the two-factor model in this section
• [In progress]

Chapter II - Foundational issues on interest rate modeling

135

## Page 137

Three-factor models

• Need at least three factors to explain the entire variation in the yield-curve–not only stochastic volatility

• A natural extension: the drift of the short-term rate contains some predictable component, ¯ say. This component acts as a third factor, as in the following model

 

= =

 

(¯ −  )  (¯ −  ) 

+ √√ 1 + √  2

(12)

¯ = ¯ (¯ − ¯ )  + ¯ ¯ 3

where    ¯  ¯ ¯ and ¯ are constants, and [1 2 3] is vector Brownian motion. Balduzzi et al. (1996) develop the ﬁrst model of this kind. Dai and
Singleton (2000) consider a number of models that generalize that in Eqs. (12).

Chapter II - Foundational issues on interest rate modeling

136

## Page 138

• The term-structure implications of these models

— First, the zero coupon bond price now is:  ( ¯   − ) such that, under reasonable conditions, the yield curve is

 ( ¯   − ) ≡ − ( − )−1 ln  ( ¯   − )

— Second, and intuitively, changes in the new factor ¯ should primarily aﬀect the long-end of the yield curve ∗ The usual empirical ﬁnding is that the short-term rate reverts quickly to the long-term factor ¯ (i.e.  is high), where ¯ mean-reverts slowly (i.e. ¯ is relatively low) ∗ Ultimately, then, the slow mean-reversion of ¯ implies that changes in ¯ last for the relevant part of the term-structure we are usually interested in (i.e., up to 30 years)–of course, we have that lim →∞  ( ¯   − ) is independent of , ¯ and . But what matters is
• Unfortunately, it is diﬃcult to reconcile these properties with the existence of any of the factors discussed in the previous chapter
— Indeed, the short-term rate cannot be a “level factor”–its eﬀects die oﬀ relatively quickly ( is high)
— Instead, a joint change in  and ¯, should be really needed to mimic the “Level” panel of the previous ﬁgure. ∗ However, this interpretation is at odds with the assumption that the factors are uncorrelated

Chapter II - Foundational issues on interest rate modeling

137

## Page 139

Mean reversion? The secular decline in interest rates

• Natural interest rate (real): the interest rate that leads to full output

=⇒ Sometimes a.k.a. “R-star” — Related to Wicksellian interest rate (the rate at which inﬂation is stable)

• Diﬃcult to estimate

• We usually “ﬁlter” the state from a model such as

  = ∗ + 1 ∗ = ∗−1 + 2

(13)

where  is some estimate of the real interest rate (e.g., nominal rate minus realized or expected inﬂation), and 1 and 2 are two random variables — We posit that the natural rate is ∗–It is not observed: what we observe is 
B The ﬁrst equation of (13) is the “observation equation”–we observe  B The second equation is the “transition equation”–it tells us how the state, ∗,
changes over time
• We use data taken from Schmelzing (2020), a long time-series of real interest rates in Europe, and estimate the state in (13)

Chapter II - Foundational issues on interest rate modeling

138

## Page 140

40 30 20 10
0 -10 -20 -30 -40 -50 -60
1300

Real interest rates (in %) in Europe - 1315-2018
Raw data Estimated "natural rate"

1400

1500

1600

1700

1800

1900

2000

Chapter II - Foundational issues on interest rate modeling

139

## Page 141

• The following picture regards estimates of U.S. 10 year real interest rate
— Available as the Cleveland Fed 10-year real interest rate ∗ https://fred.stlouisfed.org/series/REAINTRATREARAT10Y ∗ https://www.clevelandfed.org/indicators-and-data/inﬂation-expectations#background)

U.S. 10 year real interest rate (in %) - 1982 - 2023
8

7

6

5

4

3

2

1

0

-1 1980

1985

1990

1995

2000

2005

2010

2015

2020

2025

Chapter II - Foundational issues on interest rate modeling

140

## Page 142

II.6 Aﬃne models

• The Vasicek and CIR models predict that the price of any zero is exponential-aﬃne in the short-term rate . This property is the expression of a general phenomenon. Indeed, it is possible to show that the price of any zero is exponential-aﬃne in  if, and only if, the functions  and 2 are aﬃne in . Models that satisfy these conditions are known as aﬃne models. More generally, these basic results extend to multifactor models, in which the price of any zero is exponential-aﬃne in the state variables.
• In these models, the short-term rate is a function  () such that

 () = 0 + 1 · 
where 0 is a constant, 1 is a vector, and  is a multidimensional diﬀusion, in R, and is solution to:

 =  ( −  )  + Σ ( )  

where  is a -dimensional Brownian motion, Σ is a full rank  ×  matrix, and  is a full rank  ×  diagonal matrix with elements,



 ()() =  + >   = 1 · · · 

(14)

for some scalars  and vectors .

Chapter II - Foundational issues on interest rate modeling

141

## Page 143

• Under the assumption that the risk-premia Λ are

Λ () =  () 1

for some -dimensional vector 1, Duﬃe and Kan (1996) show that the price of any zero is exponential-aﬃne in the state variables . That is, the price of the zero has the following functional form,

 (  − ) = exp [ ( − ) +  ( − ) · ] 

for some functions  and  of the time to maturity,  −  ( is vector-valued) such that  (0) = 0 and  (0)() = 0.

Chapter II - Foundational issues on interest rate modeling

142

## Page 144

Proof of Eq. (1)

* Appendix

Let  ( ) denote the price of a zero with maturity   = 1 2, when the interest rate is equal to . We wish to replicate a zero with maturity 2 by means of a portfolio that includes a zero with maturity 1.

Consider the following portfolio: (i) Go long ∆ zeros with maturity 1 and (ii) invest  in the MMA. Let 0 be the current value of this portfolio. 0 is clearly a function of the current short-term rate , and equals,

0 () = ∆ ·  ( 1) +  In the second period, the value of the portfolio is random, as it depends on the development of the

short-term rate ˜. Precisely, the value of the portfolio in the second period, is

  (˜) =

 (+) = ∆ ·  (+ 1) +  · (1 + ) with probability   (−) = ∆ ·  (− 1) +  · (1 + ) wit probability 1 − 

We also know that in the second period, the value of the second zero is,

  (˜ 2) =

 (+ 2)  (− 2)

with probability  with probability 1 − 

Next, we select ∆ and  to make the value of the portfolio equal the value of the second zero, in each

state of nature, viz

 (˜) =  (˜ 2)  in each state.

Mathematically, this is tantamount to solving the following system of two equations with two unknowns (∆

and ),

  (+) = ∆ ·  (+ 1) +  · (1 + ) =  (+ 2)  (−) = ∆ ·  (− 1) +  · (1 + ) =  (− 2)

(15)

Chapter II - Foundational issues on interest rate modeling

143

## Page 145

The solution is,

∆ˆ

=

 (+  (+

2) 1)

− −

 

(− 2) (− 1)



ˆ

=



(− 2) (+ [ (+ 1)

1) −  (+ 2) (− −  (− 1)] (1 + )

1) 

By construction, the previous portfolio, (∆ˆ  ˆ ), replicates the value of the second zero in the second period.

But if two assets (the portfolio, and the second zero) yield the same payoﬀs in each state of the nature, they must be worth the same, in the absence of arbitrage. Therefore, we must have,

0 ()|∆=∆ˆ =ˆ = ∆ˆ ·  ( 1) + ˆ =  ( 2) 

or,

(1 + ) ˆ = (1 + )  ( 2) − (1 + ) ∆ˆ ·  ( 1) 

(16)

Next, let us ﬁgure out the prediction of the model in terms of the expected return it generates for the price of the bond maturing at 1, when (∆ ) = (∆ˆ  ˆ ). To do this, multiply the ﬁrst equation in (15) by , and multiply the second equation in (15) by 1 − . Add the result for ∆ = ∆ˆ   = ˆ to obtain,

∆ˆ

·

  (+

1)

+

(1

−

)  (−

 1)

+

ˆ

·

(1

+

)

=

 (+ 2)

+

(1

−

) (− 2)

Replacing (16) into the previous equation yields,

 ∆ˆ · 

(+

1)

+

(1

−

)



(−

 1)

−

(1

+

)

(

 1)

=

 

(+

2)

+

(1

−

)

(−

 2) −(1+)

(

2)



Chapter II - Foundational issues on interest rate modeling

144

## Page 146

Finally, replacing the solution for ∆ˆ into the previous equation leaves,

 

(+

1)

+

(1

−

)

(−

 1)

−

(1

+

)

(

1)

 

(+

2)

+

(1

−

)

 (−

 2)

−

(1

+

)



(

2)



+

 1

−



−

 1

=



+

 2

−



−

 2



• The previous equation is easy to interpret
— The numerators are the expected excess returns from holding the assets. ∗ They equal  [ (˜ )]−(1 + )  ( ), where  [ (˜ )] is what the investors expect to receive, the next period, by investing $  ( ) today, in the bond; and (1 + )  ( ) is what the investors expect to receive, the next period, by investing $  ( ) today, in the MMA.
— The denominators constitute a measure of volatility related to holding the assets.
• Then, the previous equation tells us that the Sharpe ratios, or the unit risk premiums, on the two zeros agree.

Let the Sharpe ratio on any zero be equal to some function  of the short-term rate  only (and possibly of calendar time). This function, , does not clearly depend on the maturity of the zeros. Then, we have,

 

(+

1)

+

(1

−

)

(−

 1)

−

(1

+

)



(

1)

=

 

(+

1)

−



(−

 1)



=

 (+

1) +

− −

 (− −

1)

·

[(+

−

−)]

(17)

We can interpret (+ − −) as a measure of interest rate volatility, and deﬁne Vol(˜ − ) ≡ (+ − −). Eq. (1) follows by rewriting Eq. (17) for a generic maturity date   2.

Chapter II - Foundational issues on interest rate modeling

145

## Page 147

Chapter III Introduction to the industry modeling practice

Chapter III - Introduction to the industry modeling practice

144

## Page 148

III.1 The Ho and Lee model

Table of contents

III.2 Beyond Ho and Lee: Calibration

III.3 Continuous time: Introduction

III.4 The market model

* Appendix

Chapter III - Introduction to the industry modeling practice

145

## Page 149

III.1 The Ho and Lee model

• Ho and Lee (1986) introduce a revolutionary approach to modeling yield curve movements. They do not derive any economic theory of determination of the term structure of interest rates. Rather, they take the yield curve as given, and then model the movements of the entire yield curve in order to price interest rate derivatives.
• The main idea underlying the Ho and Lee model is to model the movements of the yield curve along a binomial tree, much in the spirit of the Cox, Ross and Rubenstein (1979) tree representation of the Black and Scholes (1973) model. The main issues are,
— In Black and Scholes (1973) and Cox, Ross and Rubenstein (1979), the asset underlying the option contract is a traded risk. So the underlying asset price satisﬁes the martingale condition.
— Interest rate derivatives, instead, generally depend on non-traded risks. — The mere presence of boundary conditions induce bond return volatility to be
time-varying.

Chapter III - Introduction to the industry modeling practice

146

## Page 150

The tree
The price of any zero evolves randomly over time, according to a binomial tree. Let  (  ) be the price of a pure discount bond as of time , with time to maturity  − , after  upstate price movements. Let  ∼  ( 1 − ), a binomial random variable,
 () =  (1 − ) ;   () =  (1 − ) 

where 1 −  is the risk-neutral probability of a single upstate movement. Therefore we

have,

+1 ( + 1  ) 1− %

 (  )

&

 ( + 1  )

That is, if at time , the number of upstate movements is equal to  then, at time  + 1,

the number of upstate movements can either jump to  + 1, with probability 1 − , or

stay at , with probability . Note also that after one period, the price of any zero is one

period closer to maturity. At maturity,  =  , the price of any zero is worth one unit of

num´eraire, viz

 (  ) = 1, for all  and 

Note, in the previous tree, it shall not necessarily hold that  ( + 1  )   (  ).

Chapter III - Introduction to the industry modeling practice

147

## Page 151

On the contrary, we would expect that especially when the maturity approaches,

 ( + 1  )   (  ), as the price of the zero needs to converge to par.

Chapter III - Introduction to the industry modeling practice

148

## Page 152

The price movements and the martingale restriction

In the absence of arbitrage opportunities, the expected return on the zero at  must equal the short-term rate, viz  (  ) = −() (· ( + 1  )), or

 (  ) =  (  + 1) [(1 − ) +1 ( + 1  ) +  ( + 1  )]  (1)

where  (  + 1) = −(), and  () is the continuously compounded short-term rate at time  after  upward movements.

Let us introduce notation for the movements of the price of any zero along the tree,

+1 ( + 1  ) =  ( − )

1

and  ( + 1  ) =  ( − )

1

(2)

  (  )



 (  + 1)

  (  )



 (  + 1)

up at 

down at 

The two functions  (·) and  (·), also called “perturbation functions”, are introduced to capture the fact that in the case of uncertainty, the price of the zero can either go up or down with respect to the risk-free of return.

In other words, Eqs. (2) tell us that the discounted gross return from going long a bond is:



 ( + 1  )

  ( − ) with probability 1 − 



 (  )



·



(+
Discount

1)

=

 ( − )

with probability 

Gross return

Chapter III - Introduction to the industry modeling practice

149

## Page 153

where the two functions  ( − ) and  ( − ) have to be determined endogenously. If there was no uncertainty, we would have  ( − ) =  ( − ) = 1, for all  ≤  . In general, we have that  ( − ) ≤ 1 ≤  ( − ), as we shall now demonstrate.

One period before the expiration date, i.e. at  =  − 1, our price is certain to jump to one, with jump size equal to the short-term rate  (). This simple consideration leads to the following boundary condition for the two functions  (·) and  (·),

 (1) =  (1) = 1

(3)

In terms of the two functions  (·) and  (·), the martingale restriction in Eq. (1) is,

1 = (1 − )  ( − ) +  ( − )   ≤ 

(4)

This relation is quite familiar as it matches the standard risk-neutral relation for stock prices in which the short-term rate is tied down to the up and down movements of the stock price.

However, in this context the up and down movements of the zero price depend on the maturity of the price itself through the two functions  ( − ) and  ( − ), which makes the evaluation problem more intricate.

Chapter III - Introduction to the industry modeling practice

150

## Page 154

The recombining condition

Ho and Lee consider a recombining tree: the price  (  ) we are looking for depends only on , not on the exact sequence of up and down movements leading to  upstate movements.

• To summarize, we are looking for two functions  ( − ) and  ( − ) such that (i) the no-arbitrage condition in Eq. (4) holds true and (ii) the tree is recombining. We now elaborate the arguments that lead to the recombining property of our tree.

+2 ( + 2  ) %

+1 ( + 1  )

%

&

 (  ) &

+1 ( + 2  ) %

 ( + 1  ) &

 ( + 2  )

The recombining property of the tree implies that the bond price at time  + 2 in the event of  + 1 jumps, i.e. +1 ( + 2  ), can be generated by one of the two paths:
(i) The path  (  ) → +1 ( + 1  ) → +1 ( + 2  ) → “up & down” (ii) The path  (  ) →  ( + 1  ) → +1 ( + 2  ) → “down & up”

Chapter III - Introduction to the industry modeling practice

151

## Page 155

• Deﬁne the constant  by:

−1

≡

+1

(

+

1 

+

2) 

 ( + 1  + 2)

By taking natural logs,

ln

−1

=

ln

+1 ( + 1  + 2)  ( + 1  + 2)

=

− [+1

(

+

1)

−



(

+

1)]



(5)

• We know that conditionally upon time  and (price) jumps equal to  ≤ , the shortterm rate is binomially distributed, and can take on two values: (i) +1 ( + 1) with probability (1 − ) and  ( + 1) with probability . Then, the conditional variance of the short-term rate is,

[˜ ( + 1)] =  (1 − ) [+1 ( + 1) −  ( + 1)]2 

where [˜ ( + 1)] is conditional variance at time , of the short-term rate oneperiod ahead. Then, we may use Eq. (5), and the previous equation, to obtain,





[˜ ( + 1)] =  (1 − ) · ln −1

That is,  is a parameter related to the volatility of the short-term rate.

Chapter III - Introduction to the industry modeling practice

152

## Page 156

• In this basic model,  is constant. — In general,  could be time-varying, although it is then diﬃcult to ﬁnd closed-form solutions for the model.
• The Appendix shows that the solutions for the functions  and  are given by:

1

 −−1

 ( − ) = 1 −  +  −−1   ( − ) = 1 −  +  −−1 

(6)

• So we have solved the problem. We know how to “populate” the tree. Suppose we know how to assign values to  and . Given  and , and an initial bond price  (  ), we can use Eqs. (2) to populate the tree, using the solution for  ( − ) and  ( − ) given in Eqs. (6). In this way, we can ﬁgure out the exact bond prices to insert in each node of the tree.
• Once we have computed the bond prices in each node, we can price interest rate derivatives, i.e. the asset the payoﬀ of which depend on the particular value taken by the bond price on a given set of nodes.
• In fact, we can do even more, and provide a closed-form solution for the bond price predicted by the Ho and Lee model (i.e. with ﬁxed ). The Appendix shows that:



(  )

=

$ (0  )( −)(−) $ (0 )

−1
=

1 −  + − 1 −  + 

(7)

Chapter III - Introduction to the industry modeling practice

153

## Page 157

where $ (0 ) and $ (0  ) are market prices.

Chapter III - Introduction to the industry modeling practice

154

## Page 158

• Here is what Ho & Lee model does: create randomness at  (needed to price derivatives) while making sure that the initial yield curve is priced without errors (and pinning down the boundary condition that  (  ) = 1 for each .

1
P (0,T)
0
0

P (T,T)=1

j=t

j

P (t,T)
j

j=0

t

T

Chapter III - Introduction to the industry modeling practice

155

## Page 159

Calibration of the model

We need to “estimate” the value of . We can proceed as follows. Consider Eq. (7), and let  =  + 1. We have,



(



+

1)

=

$ (0  + 1)−

$ (0 )

1

−

1 +



The continuously compounded short-term rate predicted by the model is,





 () ≡ − ln  (  + 1) = ˆ (0) + ln 1 −  +  − ( − ) ln   ≤ 

where ˆ (0) ≡ ln  (0 ) − ln  (0  + 1). We also have,  (1) −  (0) = ˆ1 (0) − ˆ0 (0) + ln (1 −  + ) + ln −1 · (1 − ) 

Hence, the parameter  can be chosen so that the volatility of the short-term rate predicted

by the model matches exactly Concretely, we can take ˆ =

the volatility exp(− Std

of the short-term (∆)/  (1 −

rate )),

that we see in the data. where Std(∆) is the

standard deviation of the short-term rate in the data.

Note, then, the interesting feature of the model. The Ho and Lee model doesn’t take any a priori stance on the dynamics of the short-term rate. Rather, it imposes the martingale restriction on bond prices (an economic restriction), and the simplifying assumption that the tree is recombining (a technical condition).

Chapter III - Introduction to the industry modeling practice

156

## Page 160

These two simple conditions are suﬃcient to tell what to expect from the dynamics of

the short-term rate. While deliberately simple, the Ho and Lee model is quite powerful.

The modern approach to interest rate modeling simply aims to make the Ho and Lee

methodology more accurate for practical purposes.

Chapter III - Introduction to the industry modeling practice

157

## Page 161

One example

Assume that three zero coupon bonds are available for trading, with current market prices: (i) $ (0 1) = 09851 (the price of a 6M zero), (ii) $ (0 2) = 09685 (the price of a 1Y zero), and (iii) $ (0 3) = 09445 (the price of the 1.5Y zero). We know that the price of one-period zero at time , in the event of  upward price-jumps from the current date to , is:



(



+

1)

=

$ (0  + 1)−

$ (0 )

(1

−

1 )

+



 ≤ 

(8)

where $ (0 ) is the current market price of a zero expiring at time , with  equal

to six months, one year and eighteen months, in this example.

We

assume

that



=

1 2

and  = 09802. The second (formative) assignment solve this model through the

Arrow-Debreu security prices to be introduced later on.

The dynamics of the short-term rate

We want to determine the evolution of the short-term rate on a recombining tree for as many periods as we can, given the market price of the zeros we observe.

We use Eq. (8) to ﬁnd the one-period zeros in each node.

Chapter III - Introduction to the industry modeling practice

158

## Page 162

We have:

•  = 0. We have, trivially,  (0 1) = $ (0 1) = 09851.

•  = 1. We have three cases:

—



=

0:

0 (1 2)

=

2

$(02) $(01)



1 1+

=

09733

—



=

1:

1 (1 2)

=

2

$(02) $(01)

1 1+

=

09930

•  = 2. We have two cases:

—



=

0:

0 (2 3)

=

2

$(03) $(02)

2

1 1+2

=

09557

—



=

1:

1 (2 3)

=

2

$(03) $(02)



1 1+2

=

09750

—



=

2:

2 (2 3)

=

2

$(03) $(02)

1 1+2

=

09947

So we face the tree below.
P 0,1  0 .9 8 5 1

q



1 2

q



1 2

P 1,2   0 .9 7 3 3

P 2,3  0.9 5 5 7 P 2,3  0.9 7 5 0

P 1,2   0 .9 9 3 0

P 2,3  0.9 9 4 7

t 0

t 1

t 2

Chapter III - Introduction to the industry modeling practice

159

## Page 163

Pricing a coupon bearing bond

Suppose, now, that we want to ﬁnd the price of some additional bond, e.g., a 1.5Y bond which pays (semiannually) coupons at 3% of the principal of $1. First, we need to ﬁnd the value of this bond in each node of the tree. Note, at each node, the price equals (i) the discounted expectation of its future value (including coupons), plus (ii) the current coupons, as illustrated in the tree below. That is, the convention, here, is that the bond purchased at time  doesn’t give the owner the right to receive any coupon at time , only from time  + 1 onwards.

P0,1  0.9 8 5 1

PU U 2,3  0.9 5 5 7 0.0 3  PU U 2,31.0 3  1.0 1 4

q



1 2

P 1,2   0.9 7 3 3

0.0 3 

q



1 2

P

1,

2



1 2

1

.0

1

4



1 2

1

.0

3

4



1.0 2 6 7

PU D 2,3  0.9 7 5 0

0.0 3  PU D 2,31.0 3  1.0 3 4

P 1,2  0.9 9 3 0

0.0 3

P

1,

2



1 2

1

.0

3

4



1 2

1

.0

5

4



1.0 6 6 7

PD D 2,3  0.9 9 4 7 0.0 3  PD D 2,31.0 3  1.0 5 4

t 0

t 1

t 2

£1.0 3
£1.0 3
£1.0 3 £1.0 3
t 3

Chapter III - Introduction to the industry modeling practice

160

## Page 164

Naturally, the bond does not pay coupons at time zero. Therefore, the current price is,

1

1



1

1



 =  (0 1) 10267 + 10667 = 09851 10267 + 10667 = 10311

2

2

2

2

Pricing European options

Next, we wish to ﬁnd the price of options, say the price of two call options on the 1.5Y

bond considered in the previous subsection, when the strike price is $1 and the maturities

of the options are 6 months and 1 year. Again, we need to ﬁgure out the no-arbitrage

movements of the ex-coupons bond price. (This is because if we purchase the bond today,

we are not entitled to receive any coupon, today. The ﬂow of coupons we are entitled

to receive starts from the next period.) We easily obtain the tree below. We must just

subtract the coupon, 0.03, from each cum-coupons price in each node of the tree. Then,

we obtain:

P  1.014 0.03  0.984

q



1 2

P  1.0267 0.0 3  0.9 9 7

q



1 2

P0,1  0.9851

P  1.034 0.03  1.004

P  1.0667 0.03  1.0367

P  1.05 4 0.0 3  1.0 24

t 0

t 1

t 2

Chapter III - Introduction to the industry modeling practice

161

## Page 165

We are ready to price the two options. As for the call option on the 1.5Y bond, with 6 months maturity, and strike price  = $1, we have the following tree:

q



1 2

P0,1  0.9851

C?

P  0.997
C  maxP  K ,0 0

P  1.0367
C  maxP  K ,0 0.0367

t 0

t 1

Therefore,



=

09851

1

·

0

+

1

·

 00367

=

1808

×

10−2

2

2

Chapter III - Introduction to the industry modeling practice

162

## Page 166

The call option on the 1.5Y bond with 1 year maturity, and strike price  = $1, is dealt with similarly. We have the following tree:

q



1 2

P1,2  0.9733

C



P

1,2

1 2



0



1 2

0.0 0 4



0.0 0 1 9

q



1 2

P0,1  0.9851

C ?

P  0.984
C  m axP  K ,0  0
P  1.004
C  m axP  K ,0 0.004

P1,2  0.9930

C



P

1,2



1 2

0.0 0 4

1 2

0.0 2 4



0.0 1 4

P  1.024
C  m axP  K ,0 0.024

t 0

t 1

t 2

Therefore, the price of the option is,

1

1



 =  (0 1) 00019 + 0014

2

2

=

09851

1 00019

+

1



0014

=

7831

×

10−3

2

2

Chapter III - Introduction to the industry modeling practice

163

## Page 167

III.2 Beyond Ho and Lee: Calibration

• The modeling approach in the previous sections imposes no-arbitrage conditions on the price of the zeros, thereby determining the implied stochastic process for the short-term rate.
• In this section, we show how to implement this approach by looking for, or ﬁtting, the “right” short-term rate process in the ﬁrst place. Practitioners might prefer to “view” the Ho and Lee model by the same “calibration” perspective we develop in this section. To illustrate how the calibration works, we develop three points:
— First, we introduce an important concept, that of an Arrow-Debreu security. As we shall see, Arrow-Debreu securities are conceptually very useful, as they allow us to turn the “martingale condition” of the previous sections to a set of analytically simpler conditions.
— Second, we use these Arrow-Debreu securities to describe a general algorithm to “populate” the short-term rate tree, while ensuring that the initial term-structure is perfectly ﬁtted.
— Finally, we apply the previous algorithm to illustrate how to solve two models, in practice: ∗ The Ho and Lee model ∗ The model developed by Black, Derman and Toy (1990).

Chapter III - Introduction to the industry modeling practice

164

## Page 168

Arrow-Debreu securities

An Arrow-Debreu security is a security that promises to pay $1 in some prespeciﬁed state of the nature, and zero otherwise. (Below, it pays at time  + 1 and in state .)

1 (0,0) t=0

x x
t = 0.5

0

q x0

x s, τ

1 − q x $1

q

s, τ +1

x

s − 1, τ

1−q x 0

1 Arrow-Debreu security
1

x

0

x0

0

t=1

t = 1.5

t=2

In this diagram,  is the risk-neutral probability of an upward movement of the short-term rate. A generic pair (  ) at each node tracks the number of upward movements of the short-term rate, , and calendar time,  , where of course  ≤  (since there is only one possible short-term rate movement in each period). From now on, let us focus attention on the Arrow-Debreu security for the state  at time  + 1.

Chapter III - Introduction to the industry modeling practice

165

## Page 169

Let  ( ) denote the current price of an Arrow-Debreu security that pays oﬀ $1 in state

 at time  , and zero otherwise. Then, the current market price of a zero that matures at

time  is necessarily,

  $ (0  ) =  ( ) 

=0

More generally, consider a derivative that pays oﬀ  ( ) in node (  ), meaning a dividend equal to 1 ( ) in state  = 1, equal to 2 ( ) in state  = 2 · · · , and equal to  ( ) in state  =  . The price of this asset, denoted as $ (0  ), is given by,

 

$ (0  ) =  ( )  ( ) 

(9)

=0

Our objective, now, is to “recover” the price of the Arrow-Debreu securities  ( ) for all  and  , where  ∈ {1 · · ·   }, from the observation of the initial term-structure of interest rates.

Chapter III - Introduction to the industry modeling practice

166

## Page 170

• Consider the Arrow-Debreu security that promises to pay $1 in node (  + 1) (see Figure 1). Let its value at time  in state  ( ≤  ) be denoted as  [  + 1]. What is this value at time  in all states?
• The key observation, here, is that in this binomial tree, the node (  + 1) (the ﬁlled circle) can only be “accessed to” through the nodes (  ) and the nodes ( − 1  ) occurring at time  (the two empty circles in Figure 1). For this reason,
— At time  , the value  [  + 1] is zero in all the nodes (  ) except the empty circles (  ) and ( − 1  ) in Figure 1. This is because starting from any node diﬀerent from these empty circles, it is impossible to reach the node (  + 1) (the ﬁlled circle) on which the Arrow-Debreu security pays oﬀ.
— So, we are left with ﬁnding the values  [  + 1] in the nodes corresponding to the empty circles (  ) and ( − 1  ), i.e.  [  + 1] and −1 [  + 1]. Let  ( ) be the continuously compounded short-term rate in node (  ). ∗ Consider the upper node (  ). We have,
 [  + 1] = −() [0 ·  + 1 · (1 − )] = −() (1 − ) 

∗ Similarly, in the lower node, ( − 1  ), −1 [  + 1] = −−1() [1 ·  + 0 · (1 − )] = −−1()

Chapter III - Introduction to the industry modeling practice

167

## Page 171

• We can think of our Arrow-Debreu security for (  + 1) as a derivative that at time

 pays oﬀ the following “payoﬀs“

    [  + 1] = −() (1 − )

 

−1 [  + 1] = −−1()  [  + 1] = 0 for all   

(10)

These “payoﬀs” are simply the market value of the Arrow-Debreu security for (  + 1), in the various states occurring at time  , i.e. the money the holder can make by selling the asset at time  , in the various states. Therefore, we can apply Eq. (9) to obtain,
   ( + 1) =  ( )  [  + 1]
=0
=  ( )  [  + 1] + −1 ( ) −1 [  + 1] 

• By replacing the Arrow-Debreu prices in (10) into the previous equation, we obtain the so-called forward equation for the Arrow-Debreu prices,

 ( + 1) =  ( ) −() (1 − ) + −1 ( ) −−1()

(11)

Chapter III - Introduction to the industry modeling practice

168

## Page 172

The algorithm in two examples

• The algorithm aims to populate the interest rate tree by making a repeated use of the forward equation (11) and the zero pricing equation,
$ (0  + 1) =    ( ) −()
=0
which follows by Eq. (9). The input is, of course, a number of zeros equal to the largest maturity date the tree extends to. • We describe how the algorithm works by developing two concrete examples.

Chapter III - Introduction to the industry modeling practice

169

## Page 173

Example: calibrating the Ho and Lee model

We assume continuous compounding, for analytical reasons clariﬁed below. One important relation derived earlier states that:

 ( ) = ˆ (0) + ln ( + (1 − )  ) − ( − ) ln 

(12)

where ˆ (0) is the continuously compounded forward rate, at time zero, for maturity [   + 1], and  is the number of upward movements of the bond prices.

Naturally, then,  ≡ ( − ) is the number of downward movements of the bond prices

or, equivalently, the number of upward movements of the short-term rate. Hence, we

may equivalently index the short-term rate by , instead than by , and rewrite Eq. (12)

as follows:





 ( ) = ˆ (0) + ln (+ (1 − ) ) + ln −1 · 

(13)

= 0( )

where  ( ) is the short-term rate at time  , in the event of  upward movements of the

short-term rate, and  is a volatility parameter, i.e. such that

ln −1 = Std (∆)   (1 − )

where Std (∆) is the standard deviation of the short-term rate in the data.1
1Hence, the short-term rate movements that we shall derive do depend on the value of the risk-neutral probability  that we choose.

Chapter III - Introduction to the industry modeling practice

170

## Page 174

At time zero, the price of a zero maturing at time  + 1 is:

$

(0 

+

1)

=

  

( )

−( )

=

−0( )

  

( )



=0

=0

where the second equality follows by the assumption that the short-term rate is solution to Eq. (13).

Chapter III - Introduction to the industry modeling practice

171

## Page 175

By rearranging terms in the previous equation, we obtain a closed-form expression for the

future short-term rate at time  , in the event of zero upward movements,

0

( )

=

ln




=0



(

)



$ (0  + 1)



(14)

• We use Eq. (14) and the forward equation (11) to populate the interest rate tree,

under

the

assumption

that



=

1 2

.

Precisely,

the

algorithm

proceeds

as

follows.

(i) Given the boundary condition for the Arrow-Debreu price, 0 (0) = 1, compute

the initial value of the short-term rate, 0 (0), using Eq. (14), as 0 (0) =

ln(1/ $ (0 1)).

(ii) Suppose we know the future value of the short-term rate at time  − 1, in the event

of no upward movements, i.e. 0 ( − 1). Then, given the value of 0 ( − 1), and

the price of the Arrow-Debreu securities  ( − 1) for  ≤  − 1, compute  ( )

for  ≤  , through the forward equation (11),

 ( ) =  ( − 1) −0(−1) (1 − ) + −1 ( − 1) −1−0(−1)

1 = ,
2

where the last equation follows by plugging Eq. (13) into Eq. (11). (iii) Given the Arrow-Debreu prices  ( ) for  ≤  , use Eq. (14) to compute the future
value of the short-term rate at time  , in the event of no upward movements, i.e. 0 ( ). (iv) If  =  , stop. Otherwise, go to (ii).

Chapter III - Introduction to the industry modeling practice

172

## Page 176

Example: the Black, Derman and Toy (BDT) model

In the BDT model, the short-term rate is solution to,

 ( ) = 0 ( ) ,

(15)

where  is, once again, a volatility parameter.2

For computational convenience, the BDT model assumes that the short-term rate in Eq. (15) is discretely compounded. Accordingly, we rewrite the forward equation (11) in terms of discretely compounded rates,

1

1



(

+

1)

=



( )

1

+



( )

(1

−

)

+

−1

( )

1

+

−1

 ( )

(16)

The algorithm is described in the next slide.

2In its most general form, the BDT model assumes that  ( ) =  0 ( ), where  is a volatility parameter that varies deterministically over time. This more general formulation leads to more ﬂexibility, which is useful to ﬁt the entire volatility
structure of the yield curve (also known as the term structure of volatility).

Chapter III - Introduction to the industry modeling practice

173

## Page 177

The algorithm proceeds as follows.

(i) Compute the initial value of the short-term rate, 0 (0), as the solution to,

1

$ (0 1)

=

1

+

 0 (0)

(ii) Suppose we know the future value of the short-term rate at time  − 1, in the event of no upward
movements, i.e. 0 ( − 1). Then, given the value of 0 ( − 1), and the price of the Arrow-Debreu securities  ( − 1) for  ≤  − 1, compute  ( ) for  ≤  , through the forward equation (16),

1

1

1



( )

=



(

−

1)

1

+

0

(

−

1)

(1

−

)

+

−1

(

−

1)

1

+

−10

(

−

 1)

=  2

where the last equation follows by plugging Eq. (15) into Eq. (16).
(iii) Given the boundary condition 0 (0) = 1, and the Arrow-Debreu prices,  ( ) for  ≤  , use the pricing equation for the zero,

 

1

$

(0



+

1)

=


=0

( )

1

+

0

 ( )

to solve, numerically, for the future value of the short-term rate at time  , in the event of no upward movements, i.e. 0 ( ). Note, we did not need this additional step for the solution of the Ho and Lee model, as the short-term rate 0 ( ) is known in closed form in the Ho and Lee model (see Eq. (14)).
(iv) If  =  , stop. Otherwise, go to (ii).

Chapter III - Introduction to the industry modeling practice

174

## Page 178

III.3 Continuous time: Introduction
• Consider Ho & Lee in continuous time (+ extensions)

• In continuous time, the Ho and Lee model is very simple to analyze.

• The idea is the same. We wish to model the evolution of the forward rates in such a

way that the current term-structure of interest rates is perfectly ﬁtted by the model.

• The primitive is the model,

 =   + ˜    ≥ 

(17)

where ˜ is a -Brownian motion,  is a constant, and  is an “inﬁnite dimensional” parameter introduced to pin down the initial, observed term structure. The time of evaluation is .
— We refer to  as “inﬁnite dimensional” parameter because  is going to be a function of calendar time  ≥ 
— This function is known at the time of evaluation .
• Note that Eq. (17) gives rise to an aﬃne model of the type seen in Chapter 2. Therefore, the bond price takes the following form,

 (     ) = ( )−( )· 

(18)

for two functions  and  to be determined below. Easy to show that,

(   )

=




 (

−

 ) 

+

12 ( 6

−

 )3

;

 (   ) =  −  

Chapter III - Introduction to the industry modeling practice

175

## Page 179

• The instantaneous forward rate  (   ) predicted by the model is,



( 

)

=

 −

ln

 (  



)

=

−2

( 

)

+

2

( 

)

 

(19)

where 2(   ) ≡ (   )/  and 2(   ) ≡ (   )/  .

• Finally, let $(  ) denote the instantaneous, observed forward rate. By matching  (  ) to $ (  ) yields:

$

(

)

=



(

)

=








−

12( 2

−

)2

+



(20)

where we  (  )

h=aveexepvalu−ated

the two  (  )

partial derivatives 2  , the drift term

( 

 ) and 2 satisfying

(  ). Because Eq. (20) also

guarantees an exact ﬁt of the term-structure. By diﬀerentiating the previous equation

with respect to  , one obtains the solution for  ,



=

  $ (  )

+

2

(

−

) 

(21)

Chapter III - Introduction to the industry modeling practice

176

## Page 180

The Hull and White (1990) extension

• Hull and White consider a number of extensions, including the following simple extension. Assume the short-term rate is solution to:

 = ( −  )  + ˜  

(22)

where ˜ is a -Brownian motion, and   are constants.

• Eq. (22) also gives rise to an aﬃne model. Therefore, the solution for the bond price is given by Eq. (18), where the functions  and  are now given by

 ( 

)

=

12 2






(  )2



−






(

)



and

 (   )

=

1

 1

 − −( −) 



• By reiterating the same reasoning produced to show (21), one shows that the solution

for  is:



=

  $

(  )

+

$

(  )

+

1 2 2

 1

−

 −2( −) 

(23)

Chapter III - Introduction to the industry modeling practice

177

## Page 181

• Why did we need to go for this more complex model? After all, the Ho & Lee model already enables us to pin down the entire yield curve
— Financial intermediaries may price a lot of derivatives — The yield curve is not the only thing to be exactly ﬁt–Rather it’s only the starting
point — The more ﬂexible a given perfectly ﬁtting model is, the more accurate the pricing
model becomes (a feature that is very important when it comes to price more complex derivatives).

Chapter III - Introduction to the industry modeling practice

178

## Page 182

III.4 The market model

• The Ho and Lee model implies that forward rates can become negative. • The ideas underlying a more general model, derived by Heath, Jarrow and Morton
(1992) (HJM, henceforth), are the same as those underlying the Ho and Lee model. However, the HJM model avoids negative forward rates.
• The weak point of the HJM model is that it does not lead to closed-form solutions for interest rate derivatives such as caps and ﬂoors. Also, the practical implementation of the HJM is problematic as its tree discretization is typically “bushy”, i.e. non-recombining.
• The “market model” is a special case of the HJM in which a closed-form solution is available. For this reason, it is widely used by practitioners.
• We now (i) describe the HJM methodology, in a few words; and (ii) describe the logic underlying the market model.
• The reader can ﬁnd more analytical details in Chapter 13 of Mele (2022).

Chapter III - Introduction to the industry modeling practice

179

## Page 183

The HJM methodology

• Current time is . What is the price of a zero-coupon bond at some future time  ? — At the heart of the HJM methodology is the following formula, which we provide without proving it

 (   )

=

 (  )

·

−

 

[

(

)−

()]

 (  )

where  (  ) is the instantaneous forward rate, set at  , and applying to the time period [  + ∆], with  ≥  ≥  — Note that we may begin with market values $(  ) and $(  ) and arrive at the following formula

 (   )

=

$(  )

·

−

 

[

(

)−

()]

$(  )

Easy to see that lim→  (   ) = $(  ) for all  –that is, we can ﬁt the yield curve without errors

Chapter III - Introduction to the industry modeling practice

180

## Page 184

• The previous representations of bond prices suggest that the things to model are the future forward rate movements,

 (  ) −  ( ) 

That is, the HJM methodology takes the current term-structure as given and, hence, perfectly ﬁtted, as we observe both $(  ) and $(  ) • Key is to model forward rates–let’s examine this issue in more detail

Chapter III - Introduction to the industry modeling practice

181

## Page 185

The issue

• A standard practice of market participants is to evaluate caps (which are options on interest rates) through the Black’s (1976) formula.

— We shall provide a precise deﬁnition of a cap contract in the next chapter. For the

moment, let us consider a very simple contract, which promises to pay the following

payoﬀ at some time  ,

[ () − ]+ 

where  () =  ( ) is the interest rate prevailing from time  to time –becomes known at time  –and  is some strike rate. As is clear, a caplet protects against upward movements of the interest rates. ∗ In the next chapter, we shall see that a cap contract promises to pay a series of
caplets

— We want to price this caplet–a European call option on “LIBOR”

— Price should be

E

 −




 

(

()

−

  )+



(24)

where E is the risk neutral probability

Chapter III - Introduction to the industry modeling practice

182

## Page 186

• Is it possible to go for some variant of the standard Black & Scholes formula to evaluate the option value in Eq. (24)? How to make sure that we live within the HJM world, then? There are three issues to consider: — First, the presence of the integral −    is a kind of hindrance. — Moreover,  ( ) should be lognormally distributed. — Finally, the HJM is about instantaneous forward rates, not about discretely compounded forward rates, as in Eq. (24).
• Despite these diﬃculties, we can still apply the HJM methodology to price interest rate derivatives such as caps and ﬂoors, consistently with a Black & Scholes type of formula.
— Brace, Gatarek and Musiela (1997), Jamshidian (1997) and Miltersen, Sandmann and Sondermann (1997) developed the foundations to the standard practice to use the Black’s (1976) formula to compute Eq. (24), where the forward rate is log-normal with time-varying, but deterministic volatility, and where bond prices are still generated by the HJM model.
— The resulting model is called the market model.

Chapter III - Introduction to the industry modeling practice

183

## Page 187

Some pricing results

• A basic way to price the caplet at time  (see eq. (24)) relies on the following

approximations,

E

 −




 

(

()

−

  )+

≈

−




  E

(

()

−

)+

≈  () E ( () − )+ 

(25)

where  is the short-term rate at  , E is the expectation at  under the risk-neutral

probability, and  () is the price of a zero-coupon bond expiring at time ,



()

=

E

 −












(26)

• Approximations in (25)
— First approximation relies on the assumption that the short-term rate is roughly deterministic–such that we can take it out from the expectation
— Second approximation then inconsistently reverses the rationale underlying the ﬁrst approximation–by replacing the exponential of the integrated short-term rate with its expectation, based on Eq. (26)

This approach is obviously incorrect

Chapter III - Introduction to the industry modeling practice

184

## Page 188

• The right derivation relies on a change of probability,

E

 −




 

(

()

−

  )+

=



()

E

 

1 − ()




 

(

()

−

  )+

=  () E ( () − )+ 

(27)

where E is the expectation under the -forward probability • Next steps
— Set  =  + 1, and note that

 ( + 1) ≡  (  + 1) =  (   + 1) ≡  ( + 1) 

Therefore,

E

  − 

 

(

()

−

 )+

=

 (

+

1) E +1

(

(

+

1)

−

)+

— Finally, we model  ( + 1) as a geometric Brownian motion

Chapter III - Introduction to the industry modeling practice

185

## Page 189

• We want to model forward rate  ( + 1) as a geometric Brownian motion
— It’s a martingale under  +1 (clariﬁed in the next chapter). Therefore  ( + 1) has no drift

 ( + 1)  ( + 1)

=

 

under  +1

for some constant  — Result is a Black’s 1976 formula — We don’t need  to be constant
∗ Could be a model with random volatility — But constant volatility leads to Black’s 1976 formula

Chapter III - Introduction to the industry modeling practice

186

## Page 190

Proof of Eqs. (6) and (7)

* Appendix

• First, we show that Eqs. (6) hold true. For convenience, let us reproduce Eqs. (2) here:

+1 ( + 1  ) =  ( − )

1

and  ( + 1  ) =  ( − )

1

  (  )



 (  + 1)

  (  )



 (  + 1)

up at 

down at 

• We can use these two relations to ﬁgure out the two paths leading to the bond price at time  + 2 in the event of  + 1 jumps, i.e. +1 ( + 2  ). We have: — Along the ﬁrst path,

+1 ( + 1  ) =  ( − )

1

; +1 ( + 2  ) =  ( −  − 1)

1

  (  )





(



+

1) 

+1 ( + 1  )



+1

(

+

1



+

2) 

up at 

down at +1

— Along the second path,

 ( + 1  ) =  ( − )

1

; +1 ( + 2  ) =  ( −  − 1)

1

  (  )





(



+

1) 

  ( + 1  )





(

+

1



+

2) 

down at 

up at +1

Chapter III - Introduction to the industry modeling practice

187

## Page 191

• To sum up,



≡ +1(+1 )



1

1

+1 ( + 2  )

=

 (

−  − 1) +1 ( + 1  + 2)

·

 (

− )  (  + 1) (  )

(up & down)

1

1

+1 ( + 2  )

=

 (

−  − 1)  ( + 1  + 2)

·

 ( 

−

)



(  

+

1)



(



) 

≡ (+1 )

(down & up)

• By equating the previous two equations, we obtain,

 ( − ) =  ( −  − 1) +1 ( + 1  + 2)

(28)

 ( − )  ( −  − 1)  ( + 1  + 2)

• By evaluating Eq. (28) at  =  + 2,

 (2) =  (1) +1 ( + 1  + 2) = +1 ( + 1  + 2) ≡ −1

 (2)  (1)  ( + 1  + 2)

 ( + 1  + 2)

where we assume that  is constant. Clearly, 0 ≤  ≤ 1. Substituting back into Eq. (28),

 ( − ) =  ( −  − 1)−1  ( − )  ( −  − 1)

• Therefore, given that  (1) =  (1) = 1,

 ( − ) = −( −−1)

(29)

 ( − )

Chapter III - Introduction to the industry modeling practice

188

## Page 192

• Eq. (29) gives us the condition under which the tree is recombining. To rule out arbitrage opportunities, Eq. (4) must also hold true. Therefore, we have to solve the following system of two equations (Eq. (29) and Eq. (4)) with two unknowns ( (·) and  (·)),
  ( − ) = −( −−1) ( − ) (1 − )  ( − ) +  ( − ) = 1

The solution to this system is given in Eqs. (6) • Next, we prove Eq. (7). Consider the following equation, which we give without proof:



(  )

=



(0  )

−1

1

+



(0) 

(30)

 (0 ) = 1 +  ()

It is quite natural, at this juncture, to search for the model’s predictions about the evolution of future forward rates. Not only is this task theoretically important, it is also relevant as a matter of the practical implementation of the model.
• Indeed, if the model’s predictions about the evolution of future forward rates yields a closed-form solution, the bond price at the future date ,  (  ), could be expressed in a closed-form, which might facilitate the implementation details of the model.

Chapter III - Introduction to the industry modeling practice

189

## Page 193

Let us introduce some further notation. Let  () be the forward rate as of time  after the occurrence

of  upward movements of the bond price, and let the continuously compounded forward rate ˆ () be

deﬁned as,

ˆ

()

≡

ln

 1

+



 ()



 ≤ 

By Eq. (30), then,



(  )

=

 (0  )  (0 )

−1
=

1 +  (0) 1 +  ()

=



(0

 )−

=−1ˆ

()−ˆ

 (0)


 (0 )

(31)

We have the following important result, that we shall prove later on:

ˆ

()

=

ˆ

(0)

+

ln



( + 1  ( +

− ) 1)

−

(

−

)

ln



 ≤ 

(32)

By replacing Eq. (32) into Eq. (31), and using the solution for the perturbation function  (·) in Eqs. (6), we get Eq. (7).

So we are left with proving Eq. (32). The proof proceeds by induction. Eq. (32) holds true for  = 0. Next, suppose that it holds at time . We wish to show that in this case, Eq. (32) would also hold at time  + 1. At time  + 1, we have two cases.

Chapter III - Introduction to the industry modeling practice

190

## Page 194

Case 1 : A positive price jump occurs between time  and time  + 1. In this case,

ˆ+1

(

+

1)

=

ln

+1 ( + 1 +1 ( + 1 

) + 1)









= ln  ( − )  ( ) − ln  ( + 1 − )  (  + 1)

 (  + 1)

 (  + 1)

=

ln



 ( − ) ( + 1 − )

+

ˆ

()

=

ln

 (

+ 1 − ( +  ( + 1)

1))

+

ˆ

(0)

−

[(

+

1)

−

(

+

1)]

ln 

where the ﬁrst equality and the third follow by the deﬁnition of ˆ+1 (), the second equality holds by the deﬁnition of the jump in Eq. (2), the fourth equality follows by using Eq. (32). Hence, Eq. (32) holds at time  + 1 in the occurrence of a positive price jump between time  and time  + 1.

Chapter III - Introduction to the industry modeling practice

191

## Page 195

Case 2 : A negative price jump occurs between time  and time  + 1. In this case,

ˆ

(

+

1)

=

ln

 ( + 1  ( + 1 

) + 1)









= ln  ( − )  ( ) − ln  ( + 1 − )  (  + 1)

 (  + 1)

 (  + 1)

=

ln



 ( − ) ( + 1 − )

+

ˆ

()

=

ln



 (

( − ) −(−)+1 + 1 − ) −(+1−)+1

−1

+

ˆ

(0)

+

ln



( + 1  ( +

− ) 1)

−

(

−

)

ln



=

ln

 (  (

− +

) 1)

+

ˆ

(0)

−

[(

+

1)

−

]

ln



where the ﬁrst four equalities follow by the same arguments produced in Case 1, the ﬁfth equality holds by the relation  ( ) =  ( ) −( −1) in Eq. (29) and the last equality follows by rearranging terms. Hence,
Eq. (32) holds at time  + 1 in the occurrence of a negative price jump between time  and time  + 1.

These two cases reveal that if Eq. (32) holds at time  for any  ≤ , it also holds at time  + 1, in each state of nature. By induction, Eq. (32) is therefore true. ¥

Chapter III - Introduction to the industry modeling practice

192

## Page 196

Chapter IV Interest rate derivatives

Chapter IV - Interest rate derivatives

193

## Page 197

Table of contents

IV.1 What is a term-structure derivative?

IV.2 Volatility in ﬁxed income markets

IV.3 Options on bonds

IV.4 Interest rate swaps

IV.5 Swaptions, caps, and ﬂoors

IV.6 Counterparty risk

IV.7 From LIBOR to SOFR

IV.8 Other optionalities

Chapter IV - Interest rate derivatives

194

## Page 198

IV.1 What is a term-structure derivative?

• A term-structure derivative is an asset with cash ﬂows related to the level of interest rates, or to the price of bonds.
— A bond with ﬁxed coupons isn’t an interest rate derivative because coupons and principal are independent of interest rate developments (although the initial price may reﬂect those).
— Options written on bonds are the simplest example of interest-rate derivatives — Options on bonds, interest rate swaps, caps, swaptions, callable bonds and mortgage-
backed securities are the main ﬁxed income instruments traded in the market. The purpose of this chapter is to provide a deﬁnition of these assets.
• We shall not emphasize the technical details related to the pricing of these products. The reader can ﬁnd more analytical details in Chapter 13 of Mele (2022).
— Simply deﬁne these contracts, and provide general evaluation formulae based on continuous time methods.
— Formulae can sometimes be in closed-form. — When closed-form expressions are not available, one usually proceeds through
calibration methods such as those in the previous chapter or in the Tutorials of this course.

Chapter IV - Interest rate derivatives

195

## Page 199

IV.2 Volatility in ﬁxed income markets

Aka: volatility and the persistence of interes rates

• A deﬁnition. The term-structure of volatility is the function

 → 7 Vol [ ( )] 

where  ( ) is the spot rate for the maturity  , and Vol [ ( )] is the standard deviation of this spot-rate.

• By the deﬁnition of  ( ), the term-structure of volatility can also be written as the

function

1



 7→ Vol

− 

ln



( )



where  ( ) is the price at time  of a zero coupon bond with maturity equal to  .

• It is instructive to see what this volatility looks like, for a concrete model. Consider, for example, the Vasicek model introduced in Chapter II, by which the short-term rate is solution to,  =  ( − )  + 

where  is a Brownian motion, and ,  and  are three positive constants.

Chapter IV - Interest rate derivatives

196

## Page 200

• We know that in this model,

 ( ) 1

 ( ) = −

+  ( ) 



1 − −

 ( ) =





for some function  ( ). Therefore, we have that,

1

Vol

[ ( )]

=

 

( ) Vol∞

() 

(1)

where Vol∞ () is the “ergodic” volatility of the short-term rate, deﬁned as,



2

Vol∞ () =

 2

For example, if  = 02 and  = 001, then Vol∞ () ≈ 001548, that is 1002 × Vol∞ () ≈ 154 basis points.

Chapter IV - Interest rate derivatives

197

## Page 201

• Given the previous values for  and , Figure 1 (left panel) depicts the term-structure

of volatility, i.e. Eq. (1), in basis points.

Yield volatility (in Basis Points) Bond price volatility (in %)

160

150

140

130

120

110

100

90

80

70

0

2

4

6

8

Time to maturity (years)

8

Theoretical upper bound

7

(infinite persistence)

6

5

4

3

2

1

0

0

2

4

6

8

Time to maturity (years)

• The term-structure of yield volatility is decreasing in maturity, and attains its maximum at Vol∞ () ≈ 154 basis points — However, the volatility of bond returns can be much higher (right panel), as we now illustrate.

Chapter IV - Interest rate derivatives

198

## Page 202

• First, derive the dynamics of the bond price predicted by Vasicek model.

lemma,

 ( )  ( ) = [· · · ]  + [− ·  ( )] 

Therefore, the volatility of bond returns is,

 

Vol

=  ( ) 



By Itoˆ’s (2)

• Compare Eq. (2) with Eq. (1). The main diﬀerence between the two equations is that the RHS of Eq. (1) is divided by  , which makes Vol [ ( )] decreasing with  .

•

— Otherwise, Thus, even if example, if 

iVs ocisllo∞vsee(ryto)smzaenardlol,,bthohenandv,erVerotouulrgnhvlyoltah≈teilistay,m·Veo,olwrdheirchof,ismca5an%gnbieftourqduaei.t5)eYhizgehr.o.For

— This is illustrated by the right panel of Figure 1, which depicts Eq. (2), evaluated

at the previous parameter values,  = 02 and  = 001.

• Intuitively, the short-term rate is highly persistent (i.e.,  is rather low). This persistence makes bond prices with large maturities very volatile. Mechanism:

— High persistence in the short-term rate means that a shock aﬀects the future path

of  for quite a while. — This makes the short-term rate very volatile in the long-run

— The price of a long maturity bond is very volatile as a result.

Chapter IV - Interest rate derivatives

199

## Page 203

• Figure 2 depicts the three month rate and the three months into ﬁve years (3m-5Y) swap rate and their basis point volatilities — The 3m-5Y rate is a rate that applies to 5-year maturity deals introduced below
• The 3m-5Y swap rate is much more volatile than the short-term rate

Three month B-rate 8 6 4 2 0 1998 2000 2002 2004 2006 2008 2010

Fwd swap rate, 3 months into 5 years 8 6 4 2 1998 2000 2002 2004 2006 2008 2010

250 200 150 100 50
0 1998

Volatilities of swap and short-term rates, in basis points
Swap, 3m-5Y 3-months

2000

2002

2004

2006

2008

2010

Chapter IV - Interest rate derivatives

200

## Page 204

Forward looking gauges of market volatility in the ﬁxed income space

• This is a new asset space–goes beyond equity volatility (Cboe VIX)1
• Fear gauges (just as in the equity VIX case)
• Aggregate out-of-the money options (just as in the equity VIX case)
B Expected volatility (under the risk-adjusted probability) in the time interval [  ] (today is )
I Can be interpreted as the fair value of a variance swap in some appropriate risk space
I In some cases, it’s “model free” I [Formulae provided below must be adjusted to account for the discreteness of
available derivatives data]

1Methodology for constructing these new gauges is summarized in Mele and Obayashi (2015)

Chapter IV - Interest rate derivatives

201

## Page 205

• Price volatility index (Treasury space). Under assumptions,

T-VIX ( T)

=     1

2  (T) Put (  T) +  ∞

 Call (  T) 

 −   0

2

( T)

2

where
—  ( T) is the price of a forward (for delivery at  ) on a coupon-bearing Treasury maturing at time T
— Put (  T) and Call (  T) are prices of out-of-the-money puts and calls on the forward, expiring at  and struck at 
— Finally,  is the market num´eraire: in this case,  =  ( ), the price of a zero coupon bond expiring at time  –this is not trivial

Chapter IV - Interest rate derivatives

202

## Page 206

• Interest rate volatility (Swap space) Under assumptions,

IR-VIX (  T)

=

     

1 −

2  

 



(T)
SwpnR

0

(

 ; T) 

+

∞



SwpnP
(T)

(  ; T)

 

where

—  (T) is the forward swap rate for a tenor (extending up to some time) T — SwpnR (  ; T) and SwpnP (  ; T) are the prices of out-of-the-money

swaptions receiver and payers, expiring at  , struck at , and with tenor T

—

Finally, the market  = PVBP ( )

=num´erair=e1

in 

this case is (T), where

the Price Value of Basis Point, (T)=1 is the sequence of reset

dates for an interest swap with tenor T and  = T+1 − T for all 

Chapter IV - Interest rate derivatives

203

## Page 207

• Similarly, Credit volatility (created out of options on credit default swap indices) Under assumptions,

C-VIX (  )

=

     

1 −

2  

 

CDX

(

)
SwR

0

(

;

)



+

∞

CDX

(

SwP
)

 (  ; ) 

where
— CDX ( ) is the forward CDS index spread and  is the index’s time to maturity — SwR (  ; ) and SwP (  ; ) are the prices of out-of-the-money option
receiver and payers on the index, expiring at  , struck at , and with tenor T — Finally, the market num´eraire in this case is the defaultable Price Value of Basis
Point,  = PVBP ( )

Chapter IV - Interest rate derivatives

204

## Page 208

Treasury VIX–Cboe

Treasury volatility 60
TYVIX VIXTLT
50

40

30

20

10

0 2011

2012

2013

2014

2015

2016

2017

2018

2019

2020

2021

Chapter IV - Interest rate derivatives

205

## Page 209

Cboe Interest Rate Volatility index (a.k.a. SRVIX)

*Discontinued in 2022

Chapter IV - Interest rate derivatives

206

## Page 210

Credit Volatility (Cboe & S&P)

1500
1000
500
0 2014

1000 800 600 400 200 0

2014

Credit Volatility - One-Month (U.S.) High Yield (VIXHY) and Investment Grade (VIXIG)

VIXHY VIXIG

2016

2018

2020

2022

Credit Volatility - One-Month (Europe) High Yield (VIXXO) and Investment Grade (VIXIE)

2024
VIXXO VIXIE

2016

2018

2020

2022

2024

*Launched in 2023

Chapter IV - Interest rate derivatives

207

## Page 211

IV.3 Options on bonds

• A number of Tutorials have shown how to price options on bonds while ensuring that the initial term-structure of interest rates is perfectly ﬁtted.

— Based on trees–implied binomial trees

• We now provide some details in continuous time

• Assume the only source of randomness is the instantaneous short-term rate. Therefore, the rational pricing function of a zero coupon bond is  (  ): the price at  of the zero maturing at time  when the short-term rate equals .

• Let  and  denote the expiration date and the strike of a European call option on the previous zero coupon bond. Its price at time  is



(





)

=

E

 −

 

 

(

(





)

−

 )+



(3)

where  is the strike of the option and E [·] is a conditional expectation taken under the risk-neutral probability.

Chapter IV - Interest rate derivatives

208

## Page 212

• Jamshidian (1989) showed that  (   ) can be expressed in closed-form, once we assume that the short-term rate,  , is the solution to the Vasicek (1977) model reviewed in Chapter II,



=

 ∗

−

  

+

˜  

 ∈ (  ]

(4)

where ˜  is a Brownian motion under the risk-neutral probability, and ∗,  and  are positive constants.
• The solution provided by Jamshidian (1989) “looks like” a Black-Scholes formula. It is

 (   ) =  (  ) · Φ(1) −  (   ) · Φ(2)

(5)

where  (  ) is the bond price predicted by Vasicek’s model (see Chapter II), Φ is the cumulative normal function, and

1 =





ln

 ()  ( )

+

1 2

2

;



2 = 1 − ;





1 − −(− ) 1 − −2( −)

=





2

• Beautiful formula–resembles Black & Scholes

Chapter IV - Interest rate derivatives

209

## Page 213

• Black & Scholes (1973). Stock price is  and option price is

 ( ) =  · Φ(1) − −( −) · Φ(2)





ln 1 =



−(

−)
√

+ 212 (

  −

− ) ;

2

 = 1 −  

− 

• Jamshidian (1989)

— replaces  with  (  ) (the price of the underlying) — replaces −( −) with  (   ) (discounting factor when interest rates are
random) √ — replaces   −  with 

• Volatility

— For example, asssume  is small. Then,

lim  = [ ( − )] × ( − )
↓0
— From previous calculations, we should have that for a 10-Y zero,  ( − ) ≈ 10% B then lim↓0  ≈ 10%, which is not so lower than vol in equity markets

Chapter IV - Interest rate derivatives

210

## Page 214

• Diﬀerence with Black & Scholes
— Vasicek model does not allow us to ﬁt the whole term structure: In general,  (   ) 6= $ (  ) and  (  ) =6 $ ( ) where $ (  ) and $ ( ) denote market prices
• However, it is easy to notice that the formula in (5) still holds if we use the Hull and White (1990) extension of Vasicek model (see Chapter II)
— Hull & White model allows us to perfectly ﬁt of the initial term-structure — Result is that the price  () is as in Eq. (5), with the market prices of the
zeros $ (  ) and $ ( ) replacing the model-based prices  (   ) and  (  ) • Added value of the Hull & White
— We may evaluate more complex derivatives than options on bonds in closed form (see below)
• Rarely would we obtain closed-form solutions if we wanted to rely on more general models of the short-term rate
— Would proceed with numerical methods ∗ Discretize the state space underlying the expectation in Eq. (3) ∗ Proceed with calibrating the values of the short-term rate such that the initial term-structure is perfectly ﬁtted — just as in the numerical examples developed throughout the Tutorials

Chapter IV - Interest rate derivatives

211

## Page 215

• A gist of the proof. Change probability for the expectation in (3):



(





)

=

E

 −

 

 

(

(





)

−

 )+

=



(



)

·

E

 

−

 

 (

 
  )

(

( 



)

−

 )+

=  (   ) · E [ (   ) − ]+ 

(6)

where  is the forward probability, deﬁned through2



( )

≡

 



F

=

−

 

 



 (   )

The expectation (6) can now be determined through some standard calculations

2Heuristically, note

that



( ) integrates

to one, such

that



is

indeed a probability:

 1=



( ) 

=



 .

Chapter IV - Interest rate derivatives

212

## Page 216

• Examples — Left panel: Option price (call),  (   ), against the short-term rate  — Right panel: against the underlying bond price,  (  ))
• Based on evaluation formula (5)
— Bond maturity  −  = 10 years. Option expiration = 6 months. Strike  = 065. Parameter values: ¯ = 6%,  = 003,  = −0015 ∗ Solid lines: Speed of mean reversion  = 02 ∗ Dashed lines: Speed of mean reversion  = 01
B Option values increase with persistence. Why?

Chapter IV - Interest rate derivatives

213

## Page 217

Call price Call price

0.25

0.25

Baseline Higher persistence

Baseline Higher persistence

0.2

0.2

0.15

0.15

0.1

0.1

0.05

0.05

0 0 0.02 0.04 0.06 0.08 0.1
Short term rate, r t

0 0.4 0.5 0.6 0.7 0.8 0.9
Bond price, P(rt ,t,S)

Chapter IV - Interest rate derivatives

214

## Page 218

Options on coupon bearing bonds

• Much more relevant than options on zeros–Market deals with options on coupon bearing bonds

— ... then, futures on U.S. Treasuries (they are coupon bearing)

— ... then, options on futures on U.S. Treasuries — ... then, baskets of options on futures on U.S. Treasures (Treasury VIX)

— ... then, baskets of options on Treasury VIX (“Volatility of volatility”)

— ... =⇒ See Mele & Obayashi (2015, Chapter 4) and Mele, Obayashi, and Yang (2020) for
the delicate pricing details of these securities

• This chapter reviews options on coupon bearing bonds

• So the payoﬀ of an option maturing at 0 on a ﬁxed coupon bond paying oﬀ at dates

1 · · ·  is given by:



 



max {fcb(0 ) −  0} = max  (0 ) +  (0 ) −  0 

=1
(7)

• The expectation of the payoﬀ in Eq. (7) seems hard to compute. However, Jamshidian (1989) showed that this can be done quite simply. How?

— We consider any of the models of the short-term rate reviewed in Chapter 3, where

 (  ) =  (   )

Chapter IV - Interest rate derivatives

215

## Page 219

• Under reg conditions,  (  ) is decreasing in  and, then, there exists a unique value of , say ∗ (), which solves

∗

()

:



∗

()



0

 

+

 



∗

()



0

 

=



(8)

=1

such that the payoﬀ in (7) can then be written as

 





+

¯ 0 0  − 

=1

=

 

¯

 

 0

0

 

−



∗

()



0

+ 

=1

•

where ¯ = ,  = 1 Note that  0 0

· · · 

  − 1, −  (∗

and ¯ = 1 + . ()  0 ) have

all

the

same

sign

for

all

,

such

that the payoﬀ in (7) is

 

¯ (0

0

)

−

+ 

=

 

¯

·

  (0

0

)

−

K∗

()+

(9)

=1

=1

where K∗ () ≡  (∗ ()  0 )

Chapter IV - Interest rate derivatives

216

## Page 220

• Each term in (9) can be evaluated as an option on a pure discount bond with strike price  (∗ ()  0 )–∗ () can be found numerically
— The price of the call on the ﬁxed coupon bond is

Call

(

0;

fcb

(

)





)

=

 

¯

·

Call

 

0;



(

)



K∗

()



 



=1

where ∗ solves Eq. (8), and

Call ( 0;  K∗ ()  ) = Φ (1) − K∗ ()  ( 0) Φ (1 − ) 

1

=

ln

K∗() (0) 

+ 12

2





 = 

1−−2(0−)
2



(0

)





(  )

=

1 

1 − −( −)



Chapter IV - Interest rate derivatives

217

## Page 221

The LIBOR again

IV.4 Interest rate swaps

• Widely used deﬁnition of interest rates relies on the notion underlying the LIBOR (London Interbank Oﬀer Rate): the rate at which large ﬁnancial institutions are prepared to be charged for short-term deposits, as described in Chapter I
— Technically, LIBOR is transiting to SOFR (Secured Overnight Financing Rate)
• The simply-compounded LIBOR rate at time , for the time interval [  ], is deﬁned as the solution  to the following equation:

1

 (  ) =



(10)

1 + ( − )  (  )

• Given (  ), the instantaneous short-term rate process  is obtained as the limit,

 ≡ lim  (  ) 
 ↓

• Some pieces of notation that are useful for deﬁning and evaluating interest rate derivatives. Given a non decreasing sequence of dates {}=01···, and following Eq. (10), we deﬁne,
() ≡ ( +1)

Chapter IV - Interest rate derivatives

218

## Page 222

• In other terms, () is solution to:

1

 ( +1)

=

1

+

 ()

where

 ≡ +1 −   = 0 1 · · ·

• Moreover, we set,

() ≡  (  +1)

where  (  +1) is the forward rate introduced in Chapter I. That is, () is

solution to:

 ( +1) =

1 

(11)

 ( ) 1 + ()

An obvious but important relation is

() = ()

Chapter IV - Interest rate derivatives

219

## Page 223

Interest rate swaps: motivation

• An interest rate swap is an exchange of interest rate payments — Two counterparties exchange a ﬁxed against a ﬂoating interest rate payment ∗ For example, the counterparty receiving a ﬂoating interest rate payment has “good” (or only) access to markets for “variable” interest rates, but wishes to pay ﬁxed interest rates ∗ A pension fund may be interested in receiving ﬁxed coupon for a long period of time (due to ALM) and, hence, may be on the opposite of the deal.
• The counterparty receiving a ﬂoating interest rate payment and paying a ﬁxed interest rate irs has a payoﬀ equal to,
−1 [(−1) − irs]
at time ,  = 1 · · · . By conventions, we say that this payoﬀ describes a swap payer • We provide some motivation below

Chapter IV - Interest rate derivatives

220

## Page 224

• Savings and Loan associations (S&L) are cooperative ventures that extend mortgage, car and personal loans to individual members
— typically ﬁnanced through retail savings — governance: voting and management rights extended to their depositors and
borrowers members.
• S&Ls entered into a deep and persistent crisis during the 1980s - beginning of the 1990s
— government bailout ≈ $125b under George H. W. Bush administration — Many reasons underlying this crisis
∗ One of them: the rise in short-term rates due to the Fed ﬁght against inﬂation – so-called Monetary Experiment discussed in Chapter II
∗ Banking risks involve lending at horizons longer than those for borrowing ∗ S&L “banking” is not immune to these risks
· S&Ls had originated loans at rates lower than the interest rates on deposits (the latter increased after the Fed Experiment
• Interest rate swaps could have helped coping with the yield curve compressions of the time
— Will see how in a moment
• Below, we deal with additional products (caps, swaptions) that ensure against the upside while at the same time freeing up the downside.

Chapter IV - Interest rate derivatives

221

## Page 225

• Cost-beneﬁt analysis for private institutions. Consider the previous S&Ls example. S&Ls could have “locked-in the yield curve” with interest rate swaps

— The payoﬀ of a swap payer for the S&L could have been





−1 long (−1 ) −  (−1 ) + −1 ( (−1 ) − irs)





= −1 long (−1 ) − irs 

where long (−1 ) is some long-term rate — If short-term rates had to fall relative to irs, interest rate swaps wouldn’t have
brought any beneﬁts to the S&L — Interest rate swaps would have been the right type of insurance if a yield curve
inversion had to lead to bankruptcy and bankruptcy is costly
• Some other institutions would like to be on the opposite side of these deals–becoming a swap receiver.
— Pension funds want to have access to long-term assets that distribute ﬁxed payments, ideally, “coupons” ∗ Fixed payments enable funds to honor payments to past contributors ∗ A long maturity (i.e., a “high-tenor”) receiver swap may play such a role · Funds pay a variable interest rate (they obtain this by investing current contributions into variable rate markets) · Funds obtain ﬁxed interest rates

Chapter IV - Interest rate derivatives

222

## Page 226

— Last, but not least, pension funds are very adverse to decreasing interest rates – see the Tutorials

• Cost-beneﬁt analysis for governments. Consider a government with a considerable amount of debt already accumulated

— Likely to pay high interest rates on its debt (why?) — Considerable risk of default

• Interest rate swap payers would seem to bring beneﬁts to this government, provided interest rates increase

— Downside: governments give up to better ﬁnancing conditions (i.e., when interest rates decline)
— Apparently downside may count less than the risk of default — But downside here may be particularly severe
∗ Interest rates may be persistently very low precisely when the economy experiences persistently bad times – as, e.g., after the Global Financial Crisis of the late 2000s
∗ In these cases, government deﬁcits are typically higher than on average whilst public debt becomes more vulnerable to default risk
∗ All this weakens the case for a swap payer.

Chapter IV - Interest rate derivatives

223

## Page 227

A digression on ﬁxed income arbitrage

• Swap spread arbitrage. Seems to have been responsible for leading LTCM to a loss of about $1.6 billion in 1998. Strategy is — Enter a swap paying the ﬂoating LIBOR, , and receiving a ﬁxed rate ¯. — Short a par Treasury with the same maturity as the swap, thus paying the ﬁxed coupon rate  , and invest the proceeds at the repo rate . — Thus, the payoﬀ of the strategy is the ﬁxed spread to be received,  = ¯ −  , minus the ﬂoating spread to be paid,  =  − .
So we go long or short this strategy according to whether we view  to be larger or smaller than the average ﬂoating spread  over the strategy horizon. Historically, the spread  has certainly been volatile, but quite stable, so it seems to be a reasonable strategy. The problem occasionally, though, is that  can attain quite large values.
• Yield curve arbitrage. Short (say) ﬁve year bonds, and go long (say) two- and ten-year bonds, an implicit view that short term interest raise will raise and medium term interest rates will lower. This “butterﬂy” strategy is also known as barbell trading–seen in the Tutorials.
— This might be intellectually quite cheap and not necessarily rewarding. More sophisticated strategies rely on models, which identify which points of the yield curve are misaligned from those predicted by the model.
— A strategy, substantially, is: buy the “cheap” and short the model-based “rich” ∗ Model-based rich is replicated through a portfolio with cash and bonds that are well-priced by the model, weighted with the model-based delta.

Chapter IV - Interest rate derivatives

224

## Page 228

Interest rate swaps: some maths

• The value at  of an interest rate swap (IRS) beginning at 0 ≥  for the tenor {}=01···, and ﬁxed interest rate irs is3

IRS

=

 

E

 −

  





−1

((−1)

−

 irs)

=1

=

 

−1E

 −

  

  (−1)

−

E

 −

  


 

 irs

=1

 

= −1 [ ( −1 ) − irs]  ( ) 

(12)

=1

• This is called forward IRS. When  = 0, it’s a spot IRS

3The third equality follows because,

E

− 



 (−1)−1

=

E

− 



 

1 (−1

)

−

 1

=  ( −1) −  ( ) 
=     ( −1 )−1

Chapter IV - Interest rate derivatives

225

## Page 229

• The forward swap rate sw (0) is the value of irs such that IRS = 0. Simple calculations yield

sw

(0)

=


=1

 −1=1(−1−1( )) (

)

=

(=10)−−1(())

(13)

where the last equality is due to the deﬁnition of  ( −1 ) given in Eq. (11). • We can plug (13) into (12) and obtain the following intuitive expression for IRS,

  IRS = −1 [ ( −1 ) − irs]  ( )
=1
= PVBP · (sw (0) − irs) 

where

  PVBP ≡ −1 ( )

=1

• PVBP is the “Price Value of the Basis Point”

— The impact (in present value terms) of one bp change in the move in sw (0)

• Next step: to analyze derivatives on interest rate swaps

Chapter IV - Interest rate derivatives

226

## Page 230

IV.5 Swaptions, caps, and ﬂoors

Swaptions

• Swaptions are options to enter a swap contract on a future date. Let the maturity date

of this option be 0. Then, at time 0, the payoﬀ of the swaption is the maximum between zero and the value of an interest rate swap at 0 irs(0), viz

max

 IRS0

 0

=

PVBP0

·

 sw0

(0)

−

+ irs



(14)

where the equality holds by Eq. (12).

• The value of the swaption as of time , Sw, is,

Sw

=

E

 −

 0 

  PVBP0

·

 sw0

(0)

−

+ irs



(15)

• Proceed with the market model. A bit technical.

Chapter IV - Interest rate derivatives

227

## Page 231

Derivation of a market-type formula

• Intuition

E

 −

 0 

  PVBP0

·

 sw0

(0)

−

+ irs

=

PVBP

·

E

 −

 0 





PVBP0 PVBP

·

 sw0

(0)

−

+ irs

=

PVBP

·

Esw

 sw0

(0)

−

+ irs



where Esw is the expectation taken under sw, deﬁned through

sw

=

−

 0 





PVBP0





PVBP

• It is possible to show that the forward swap rate sw ( ) is is strictly positive and

a martingale under a certain probability called the swap probability (sw say). We

assume that

sw ( ) sw ( )

=

 sw

( ) sw

 ∈ [ 0] 

(16)

where sw is a sw-Brownian motion and for some sw ( )

Chapter IV - Interest rate derivatives

228

## Page 232

• If sw ( ) is deterministic, we can use Black’s (1976) formula and determine the payer swaption value in (15) in closed-form. We have



Sw = PVBP · B(sw; 0 irs ¯ )

(17)

where B (·) is given by Black’s (1976) formula

√

√

B(sw; 0 irs ¯ ) = swΦ () − irsΦ( − ¯ )



=

ln

sw √irs

+

¯

1 2

¯



¯

=

 0




2 sw

( )





B The economics of IRS and derivatives based thereupon • Typically traded are spot IRS, not forward IRS
• However, we need conceptualize forward IRS in order to proceed with pricing swaptions

Chapter IV - Interest rate derivatives

229

## Page 233

Caps & ﬂoors

• A cap works as an interest rate swap, with the important exception that the exchange of interest rates payments takes place only if actual interest rates are higher than . A cap protects against upward movements of the interest rates. Therefore, we have that the payoﬀ as of time  is
−1 [ (−1) − ]+   = 1 · · · 

Such a payoﬀ is usually referred to as the caplet. • Floors are deﬁned in a similar way, with a single ﬂoorlet paying oﬀ,

−1 [ − (−1)]+

at time ,  = 1 · · · . • Focus on caps. The fair value of a cap as at time  is:

Cap

=

 

E

 −

  

  −1

((−1)

−

 )+ 

=1

• Proceed with the the market model. A bit technical again.

Chapter IV - Interest rate derivatives

230

## Page 234

• Derivation of a market-type formula. Relies on a change in probability. Note, ﬁrst, that (−1) =  (−1 −1 ), such that

Cap

=

 

E

 −

  





−1

(

(−1

−1

)

−

 )+

=1

=

 
=1

E

 

(

)

−

  





 ( ) −1

( (−1

−1 )

−

 )+

=

 
=1

−1

(

) E

[ (−1

−1 )

−

]+



where the expectation is taken under the  - forward probability. • Now, −1 ≡ −1(  −1 ) is a martingale under  for  ∈ [ −1].
Therefore, −1 satisﬁes

−1 −1

= −1( )

 ∈ [ −1] 

 = 1 · · ·  

(18)

where   ( ) denotes a Brownian motion under , and for some −1( )

Chapter IV - Interest rate derivatives

231

## Page 235

• We can then use rely on the Black’s (1976) formula, provided we assume  is deterministic

E ( (−1 −1 ) − )+ = −1Φ (1−1) − Φ (1−1 − )  (19)

where

1−1

=

ln

−1 


+

1 2

2



2

 =

−1 2−1( ) 



Chapter IV - Interest rate derivatives

232

## Page 236

Main topics

IV.6 Counterparty risk

• Multiple curves • Credit Value Adjustment (CVA) • Debit Value Adjustment (DVA)

Some references

- Hull, J. (2018): Risk Management and Financial Institutions (5th edition). John Wiley & Sons–Chapter 20
- Mele, A. (2022): Financial Economics. Boston: MIT Press–Chapter 13 (Section 13.9.4)

Chapter IV - Interest rate derivatives

233

## Page 237

IV.7 From LIBOR to SOFR

• LIBOR: London Interbank Oﬀered Rate • SOFR: Secured Overnight Financing Rate

[In progress]

Chapter IV - Interest rate derivatives

234

## Page 238

IV.8 Other optionalities
Callable and puttable bonds

• Callable bonds give the issuer the right to buy them back at certain times and predetermined prices. Puttable bonds give the investor the right to sell them back to the issuer at a certain price. Let us focus attention on callable bonds.
• To evaluate callable bonds, one typically uses the tree methodology described in Chapters II and III, corrected for the presence of credit risk.
— First, we “populate” a short-term rate tree through one of the models described in Chapters II and III (say, for example, through the Black, Derman and Toy model).
— Second, we use this tree to ﬁnd the value of some coupon bearing bond of interest, by just using the short-term rate process of the previous step.
— Third, we use the results obtained in the second step and build up a tree for the callable bond. In each node immediately preceding the maturity, we compare the strike price with the non-callable coupon bearing bond price (ex-coupon) and take the minimum of the two. We add the coupon to this minimum and ﬁnd, then, the payoﬀ of the non-callable bond at the relevant node. This gives us  = min{ rolled-back(ex-coupon)} + coupon, where  is the call price, and rolled-back(ex-coupon) is the ex-coupon bond price, which is found from the values of the bond  in the next nodes (by using, as usual, recursive, backward solution, i.e. the risk-neutral expectation of the future payoﬀs).

Chapter IV - Interest rate derivatives

235

## Page 239

— Fourth, we go backward, discounting the values obtained in the previous steps,  say, obtaining, for each node, − = min{  } + coupon, etc. Hence, we ﬁnd the price. If the callable bond is not subject to default risk, we stop. Otherwise, we proceed to the next step.
— Fifth, we correct for credit risk. The price we found in the fourth step is typically diﬀerent than the market price. One issue is that the market price reﬂects the credit risk of the ﬁrm, and should be typically less than the price obtained in the fourth step. The trick, here, is to search for an additional spread to add to the short-term rate process obtained in the ﬁrst step, such that the theoretical bond price equals the market price of the bond. This is done numerically, and of course alters the results obtained in steps 3 and 4.
At this point, we may price options written on callable bonds. Ho and Lee (2004) (Chapter 8, Section 8.3 p. 274-278) develop a number of useful exercises on the pricing of options on callable bonds, through tree methods.

A few properties of callable bonds

• We illustrate a few useful properties of callable bonds. For simplicity, we consider a callable, non-defaultable bond. Let  be the strike price of the callable bond maturing at time , and suppose that the date of exercise, if any, is some future time   . Then, the payoﬀ of the callable bond at time  is, of course, min {  }, where  is the price of a non-callable bond.

Chapter IV - Interest rate derivatives

236

## Page 240

• It easy to see that

min { } =  − max { −  0} 

Therefore, the price of a callable bond with maturity date , equals the price of a non-callable bond with the same maturity date , minus the value to call the bond, which equals the price of an hypothetical option on the non-callable bond, struck at .
• We can rely on these insights and price a callable option in a concrete example. Consider, for example, the short-term rate in the Vasicek’s model introduced in Chapter II. Then, if the short-term rate is  at time , the value as of time  of the non-defaultable zero coupon bond maturing at time , callable at time   , at a strike price equal to , is,

 callable (   ) =  (  ) −  (   ) 

(20)

where  (  ) is the value of the non-callable zero maturing at time , and  (   ) is the value of a call option on the non-callable -zero, maturing at
time  and having a strike price equal to .

Eq. (20) shows that the presence of the option to call the bond raises the cost of capital for the issuer.
In the context of the Vasicek’s model, the solution to  (   ) in Eq. (20) is given by the Jamshidian’s (1989) formula given in Section IV.3, which we use below.

Chapter IV - Interest rate derivatives

237

## Page 241

• The ﬁgure below depicts the behavior of the price of the callable bond in Eq. (20),  callable ( 0  ), as a function of the short-term rate, , when the exercise price,  = 065, and  = 10,  = 05,  = 02,  = 003, ¯ = 006 ∗  − , where , the unit risk-premium, equals −17146 × 10−2.

Bond prices

0.75

0.7
Non callable
0.65
Callable
0.6

0.55

0.5

0.45 0

0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09

0.1

Short term rate, r t

• =⇒ “Negative convexity” is the property the callable bond price exhibits vis—`a-vis the short-term rate 

Chapter IV - Interest rate derivatives

238

## Page 242

Negative convexity

• =⇒ “Negative convexity”–the convexity of the non-callable bond price is destroyed by convexity of the price of the option embedded in the callable bond
— Intuitively, as the short-term rate gets small, callable and non-callable bond prices increase
— However, the price of callable bonds increases less because as the short-term rate decreases, bond prices increase and then, the probability the issuer will exercise the option, at maturity, increases
— This makes the risk-neutral distribution of the callable bond price markedly shifted towards the value of the strike price,  = 065, which entails a progressively lower decay rate for the bond price as the short-term rate gets small.
• Negative convexity and ﬁxed income market volatility: as interest rates increase (e.g., after a recession episodes comes to end), volatility ↑ and may lead to large adjustments
• Also duration increases again and leads pro-cyclical hedging (see Section I.7 in Chapter I)
— Interest rates ↑, sell-oﬀs of Treasuries (due to hedging from institutions that hold MBS)
— ... feedback loop

Chapter IV - Interest rate derivatives

239

## Page 243

• Eﬀects gauged through the previous model • Need to go beyond standard measures of duration • “Stochastic duration” (See Mele, 2022, Chapter 13)

Stochastic duration Callable price volatility

10

0.14

9
0.12 8

7 0.1
6

5

0.08

4
0.06 3

2 0.04
1

0 0 0.02 0.04 0.06 0.08 0.1
Short term rate, r t

0.02 0

0.02 0.04 0.06 0.08 0.1
Short term rate, r t

Chapter IV - Interest rate derivatives

240

## Page 244

Convertibles

• Convertible bonds oﬀer bondholders the option to convert their bonds into shares of the ﬁrm. The option to convert can be exercized at any time up to maturity.
• How do they work? By deﬁnition, the face value of the convertible is,

Face value = $1 ≡ CR ∗ CP

(21)

where CR is the conversion ratio, i.e. the number of shares this face value converts into, and CP is the conversion price, i.e. the stock price implicitly deﬁned by Eq. (21).
• Typically, the bond is any like other ﬁxed income instrument, with coupon payments, callable features, credit risk (!), etc. Callable features are almost invariably embedded into this type of contracts.

Chapter IV - Interest rate derivatives

241

## Page 245

• The parity, or conversion value, is the value of the bond if the bondholders decide to convert. It is deﬁned as, CV = CR ∗ 
where  is the price of the common share.
• So we see that not only is the convertible bond price aﬀected by interest rates, credit risk, timing risk, etc. The convertible bond price is also aﬀected by the movements of the underlying stock price. This is quite natural as there is a positive probability that the bond will “become” a share in the future. To emphasize this, we also say that convertible bonds are hybrid instruments.
• The embedded option oﬀers the bondholders the possibility to obtain equity returns (not just bond returns) in good times, while oﬀering protection against the downside.
• As mentioned earlier, convertible bonds are almost always callable. The holder can always convert the bond, once it has been called. The rationale behind callability is to induce the bondholder to convert the bond earlier.

Chapter IV - Interest rate derivatives

242

## Page 246

• The pricing problem of convertible bonds has been intensively studied, theoretically. We shall review the main lines of the arguments later on. For the moment, we present a widely used method to evaluate convertible bonds, based on trees. The evaluation tree features the following three steps.
— First, we set the life of the tree equal to the life of the callable convertible bond. — Second, we assess the evolution of the stock price along the tree, under the
risk-neutral probability. (This is done according to the usual Cox, Ross and Rubinstein (1979) approach.) — Third, in each node, we compute the value of the bond as max{CV min{ }}, where CV is the conversion value,  is the call value, and  is the value of the bond which is “rolled-back” from the values of the bond in the next nodes (by using, as usual, recursive, backward solution, i.e. the risk-neutral expectation of the future payoﬀs). That is, assuming the bondholder does not convert, the value is ∗ = min { }, where  is the “rolled-back” value of the bond. Then, the value is max{CV ∗}.

Chapter IV - Interest rate derivatives

243

## Page 247

• This procedure enables us to ﬁll in the nodes–at least as soon as we know the appropriate interest rate. If the ﬁrm was not subject to default risk, we would simply use the riskless interest rate
• However, the ﬁrm is obviously subject to default risk.
• In practice, we should proceed as follows.
— In each node, the value of the bond is decomposed in two parts. One part, related to the “pure debt component”, which is discounted at the defaultable interest rate; and one part related to the “pure equity component”, which is discounted at the default-free interest rate. Additional details are available from standard textbooks such as Hull.

Chapter IV - Interest rate derivatives

244

## Page 248

A few theoretical properties of convertible bonds

• Ingersoll (1977) provides the ﬁrst theoretical article which lays down the foundations to rational evaluation of convertible callable bonds.

• Deﬁne the dilution factor, denoted as , as the fraction of common equity that would be held by the convertible bondowners if the entire issue was converted.

• If there are out shares outstanding, and the convertible bond can be exchanged for 

shares, then, in aggregate,



=



 + out

• Let the market value of the ﬁrm be equal to the value of its assets, , which we

assume follows a Geometric Brownian motion,

 

=



+

˜ 

where ˜  is the Brownian under the risk-neutral probability. Let conv (  ;  ) be the aggregate value of the convertible bond with maturity  and balloon payment .

Chapter IV - Interest rate derivatives

245

## Page 249

• To simplify the presentation, we do not consider callability issues. However, we shall provide some intuition about this issue later. We now proceed to a qualitative analysis of the evaluation problem.
• Let us assume that the stocks and the convertible bonds are the only two claims in the capital structure of the ﬁrm. Since, after conversion, only the stocks will remain, then, the post-conversion value of the convertible bonds is simply the conversion value of the convertible, i.e. . Moreover, we have, for any  ≥ 0,

 ≤ conv (  ;  ) ≤ 

(22)

The ﬁrst inequality in (22) is simple to understand. Indeed, suppose that conv (  ;  )  . Then, we can purchase the convertibles, convert them into shares and, ﬁnally, sell the shares for . The second inequality follows by limited
liability for equities, and the Modigliani-Miller Theorem.

Chapter IV - Interest rate derivatives

246

## Page 250

• At maturity, we have that,

conv ( 0;  ) = min { max { }} 

(23)

Indeed, ¯ ≡ max { } is the value of the convertible, in case of no-default. Then, min{ ¯} is what the ﬁrm will pay, to the bondholders:  in case of default, and ¯ in case of no-default.
— It is possible to show that it is never optimal to exercize the option to convert before the maturity. Therefore, to price the convertible bond, we only need to be concerned with the risk-neutral evaluation of the terminal payoﬀ in Eq. (23).
• We can re-express the terminal payoﬀ in Eq. (23) in a manner that allows a better understanding of the issues underlying the exercise of the convertibles. In particular, we have that,

conv ( 0;  ) = min { max { }} = max { min {  }}  (24)

Indeed, let ˆ ≡ min{ }. ˆ is what the ﬁrm is ready to pay, to the bondholders, if the bondholders do not exercise the option to convert. Then, max{ ˆ} is
obviously the payoﬀ proﬁle to the bondholders.

Chapter IV - Interest rate derivatives

247

## Page 251

• The terminal payoﬀ in Eq. (24) illustrates very clearly that convertible bonds embed an option to convert - on top of the plain vanilla non-convertible bond. Intuitively, at maturity, a non-convertible bond is worth min { }, and the option to convert is either worthless (in case of non conversion) or  −  (in case of conversion), i.e. it is max { −  0}. This intuition is conﬁrmed, mathematically, as we have that:

max { min { }} = min { } + max { −  0} 

Therefore, the value of the terminal payoﬀ is, by Eq. (24),

conv ( 0;  ) = min {  } +  max { −  0} 

(25)

Eq. (25) shows that the current value of the convertible bond is the sum of the value of a “straight” bond plus the value of  options on the ﬁrm with strike price equal to .

Chapter IV - Interest rate derivatives

248

## Page 252

• So let  (  ; ) and  (  ; ) be the prices of the straight bond and the

option on the ﬁrm. We have,

conv (  ;  ) =  (  ;  ) +  (  ; )

(26)

• We may use the Merton’s (1974) model to ﬁnd the price of the straight bond,  (  ; ). By results in Chapter VII, it is:

 (  ;  ) = Φ (−1) +  − Φ (2)

1

=

ln(

/


)+ + √

1 2

2



;

√ 2 = 1 −  

(27)

where  is the instantaneous volatility of the asset value,  is the (constant)

instantaneous short-term rate, and Φ is the cumulative distribution of a standard

normal.

• Similarly, we may use the Black-Scholes model and determined the function  .

• Properties of Eq. (27) — As  gets large,  (  ;  ) ≈  − (the probability of default gets extremely

tiny as the value of the assets is large)

— As  gets large, the Black-Scholes model suggests that  (  ; ) ≈

 − − .

—

Therefore,  − +

byE−q.−(26),we=

have .

that,

for

large

,

conv (  ;  ) ≈

— Eq. (27) also shows that for small values of , conv (  ;  ) ≈ 0.

Chapter IV - Interest rate derivatives

249

## Page 253

• To sum-up, the value of the convertible bond is less than the value of the ﬁrm, , and larger than the conversion value, .4 Moreover, it approaches  as for large 

Straight and convertible bond values

200 180 160 140 120 100 80 60 40 20
0 0

100

200

300

400

500

Assets value, A0

Convertible and straight bond values against assets value, .  = 3%, asset volatility  = 020, time to maturity  = 3 years, dilution factor  = 10%, and nominal debt  = 100. Solid line: convertible value. Dashed line ﬂattening out to the constant − = 091393: straight bond value. Straight lines starting from the origins are the no-arbitrage bounds  and  in Eq. (22).
4Possible to show that the value of a callable convertible bond is between the value of the straight bond and the value of the convertible bond.

Chapter IV - Interest rate derivatives

250

## Page 254

References

Hull, John (2018): Risk Management and Financial Institutions (5th edition). John Wiley & Sons.

Mele, Antonio (2022): Financial Economics. Boston: MIT Press.

Mele, Antonio and Yoshiki Obayashi (2015). The Price of Fixed Income Market Volatility. New York: Springer Verlag, Springer Finance Series.

Chapter IV - Interest rate derivatives

251

## Page 255

Part II: Credit Risk

## Page 256

Contents
Chapter V: Conceptual approaches to valuation of defaultable securities Chapter VI: Credit-risk shifting derivatives and structured products

## Page 257

Chapter V Conceptual approaches to valuation of defaultable securities

Chapter V - Conceptual approaches to valuation of defaultable securities

253

## Page 258

V.1 What is credit risk?

Table of contents

V.2 Firm’s value (structural) approaches

V.3 Reduced form approaches: rare events (intensity) models

V.4 Evaluation in continuous-time

V.5 Assessment based on ﬁrms ratings

* Appendix A

* Appendix B

* Appendix C

Chapter V - Conceptual approaches to valuation of defaultable securities

254

## Page 259

V.1 What is credit risk?

• Credit risk: The risk that a counterparty will not honour a payment obligation.
— Loans — Corporate bonds — Derivatives
• Default, credit events
• How to assess credit risk? Three main approaches
(i) Firm’s value — Structural ∗ Merton - KMV ∗ First passage approaches and strategic defaulting
(ii) “Frequency” approaches — Reduced form ∗ “Intensity”, or “rare” events ∗ “Migration” ratings
(iii) “Hybrid” approaches, merging (i) and (ii)

Chapter V - Conceptual approaches to valuation of defaultable securities

255

## Page 260

V.2 Firm’s value (structural) approaches

• Relies on the structure of the ﬁrm. Shares and bonds as derivatives on the ﬁrm’s assets.

Stylized balance sheet

Assets

Equity (Shares)
Debt (Bonds)

• Accounting identity
Assets = Equity + Debt, or  =  + 
• At the time of debt expiration, debtholders receive the minimum between the debt nominal value and the value of the assets the ﬁrm can liquidate to honour the debt obligation. Debtholders are senior claimants
• Equity holders are residual claimants to the ﬁrm’s assets – Junior claimants

Chapter V - Conceptual approaches to valuation of defaultable securities

256

## Page 261

• We can use these basic insights to illustrate the ﬁrst model about the risk-structure of interest rates, the Merton - KMV approach.
— Equity is like a European call option written on the ﬁrm’s assets, with expiration equal to the debt expiration, and strike equal to the nominal value of debt.
— Current value of debt equals the value of the assets minus the value of equity, i.e. the value of a risk-free discount bond minus the value of a put option on the ﬁrm with strike price = nominal value of debt, as shown below: see Eq. (3).
• Merton (1974) uses the Black and Scholes (1973) formula to derive the price of debt. • Main assumption: Assets can be traded, and their value  satisﬁes,1

 

=



+

˜ 

(1)

where ˜  is a Brownian motion under the risk-neutral probability,  is the instantaneous standard deviation, and  is the short-term rate on riskless bonds.

1Eq. (1) could be thought as being generated instantaneous cash ﬂow to the ﬁrm. This would

by the following model:  make the ﬁrm value equal to

=0(=E−0∞) −+˜. F,owr heexraemplei,s

the one

could take  to be a geometric Brownian motion with parameters  and , in which case  = ( − )−1 , forever, but

we’re just ignoring this complication.

Chapter V - Conceptual approaches to valuation of defaultable securities

257

## Page 262

• Notation:

—  = Nominal value of debt

—  = Time of expiration of debt
—  = Debt value at time  ≤  — E(˜ | 0) = Expectation of a random variable ˜ , taken under the risk-neutral
probability, given the information that the current value of the assets equals 0

• As argued earlier, shareholders have long a European call option, and the bondholders are residual claimants. Mathematically,



 =

  if the ﬁrm defaults, i.e.     if the ﬁrm is solvent, i.e.  ≥ 

We can decompose the assets value at time  , into the sum of the value of equity and the value of debt, at time  ,

 = min {   } =  − max { −  0} 

(2)

≡ Equity at 

Note, also, that,

 = min {   } =  − max { −   0} 

(3)

≡ Put on the ﬁrm

Hence, credit risk raises the cost of capital.

Chapter V - Conceptual approaches to valuation of defaultable securities

258

## Page 263

140 120 100 80 60 40 20
0 0

Intrinsic value (bonds and equity)

50

100

150

200

Assets value, AT

Figure 1. Dashed line: the value of equity at the debt maturity,  , max { −  0}, plotted as a function of the value of assets,  . Solid line: the value of debt at maturity, min {  } as a function of  . Nominal value of debt is ﬁxed to  = 100.
• Convexity, and risk-taking behavior: — Convexity: Managers have incentives to invest in risky assets, as the terminal payoﬀ to them is increasing in the assets volatility, . — Concavity: The value of debt, instead, is decreasing in the assets volatility.

Chapter V - Conceptual approaches to valuation of defaultable securities

259

## Page 264

• So the current value of the bonds equal the current value of the assets, 0, minus the current value of equity. The current value of equity can obtained through the Black & Scholes formula, as equity is a European call option on the ﬁrm, struck at .
• By standard risk-neutral evaluation, then, the current value of debt, 0, is,

0 = 0Φ (−1) +  − Φ (2) 

(4)

1

=

ln

( 0/

)

 + √

+

1 2

2



;

√ 2 = 1 −  



where Φ (·) denotes the distribution function of a standard normal variable.2

2For

the

analytical

details,

note

that

0

=

−

E







 0

and,

then,

by

Eq.

(2),

0

=

−

E







 0

−

−

E



max

 

−



0

 0

=

0

−

 0Φ (1)

−



−

Φ

 (2)



where the last equality follows by the Black & Scholes formula. Eq. (4) follows after rearranging terms in the previous equation.

Chapter V - Conceptual approaches to valuation of defaultable securities

260

## Page 265

Bond value

110 100 90 80 70 60 50 40 30 20 10
0 0

50

100

150

200

Assets value, A0

Figure 2. Solid line: the no-arbitrage bound, min {0 }, depicted as a function of 0, when the nominal value of debt is ﬁxed to  = 100. Dashed line: the bond value predicted by the Merton’s model when  = 1,  = 3% and  = 20%, annualized. Dotted line: same as the dashed line, but with a larger asset volatility,  = 40%.

• Bond prices are decreasing in the asset volatility as bad outcomes are exaggerated on the downside, due to the concavity properties in Figure 1.

Chapter V - Conceptual approaches to valuation of defaultable securities

261

## Page 266

The risk-structure of interest rates

•

Obtained

with

the

standard formula 1
=−

for ln

conti0nuo=usly





compounded + S0

interest

rates

as,

where S0 is the term-spread or, simply, the spread, and equals





1

S0

=

− 

ln

0 



Φ

(−1)

+

Φ

(2)



(5)

Chapter V - Conceptual approaches to valuation of defaultable securities

262

## Page 267

Spread Spread

Beyond bankruptcy
350 300 250 200

Below bankruptcy
3000 2500 2000

150

1500

100 50

0

1

2

3

4

5

Time-to-maturity (years)

1000

500

1

2

3

4

5

Time-to-maturity (years)

Figure 3. The term structure of spreads, S0, in basis points. Safe interest rate:  = 3%; assets volatility is  = 020; nominal debt  = 100. Left panel : obtained with initial asset values 0 = 110 (top line), 0 = 120, and 0 = 130 (bottom). Right panel : obtained with 0 = 70 (top line), 80, and 90 (bottom).

Chapter V - Conceptual approaches to valuation of defaultable securities

263

## Page 268

Comments: Left panel

• Credit spreads shrink to zero with time-to-maturity
— Property stands in sharp contrast with the empirical behavior of credit spreads, which are high even for short-maturity bonds
• Reasons for this property: model relies on Brownian motions
B Brownians have continuous sample paths B Hence, given some initial assets value   , the probability of bankruptcy −→ 0
very fast as time-to-maturity goes to zero B Because credit spreads reﬂect default probabilities (see Eq. (8) below), credit
spreads shrink to zero −→ 0 very fast as well
• Section VI.3 shows this issue can be addressed assuming that ﬁrm’s default can be triggered by “jumps.”

Comments: Right panel

• Things change once we take    • Now, default prob is close to one as time to maturity approaches zero
— Reason: Brownians have continuous sample paths!

Chapter V - Conceptual approaches to valuation of defaultable securities

264

## Page 269

Asymptotic behavior of the spread predicted by the model

• If





1 2

2,

then,

as



→ ∞,

the

ﬁrm

assets

value

is

expected

to

grow

so large that default will n√ever occur, such that the bond becomes riskless and

S0

(

)

→

−

1 

ln

Φ(1

−



) → 0

— The exponential trend for  will make it unlikely that the ﬁrm assets value will fall

below the constant value .

• In other words, the Merton’s model predicts that in the long-run, things can only go well for the ﬁrm

— “View” opposite to that leading to positive spreads for long maturities

• Section VI.3 contains introductions to models that address these issues

Chapter V - Conceptual approaches to valuation of defaultable securities

265

## Page 270

A summary statistics for credity quality: distance-to-default (under Q)

• We can use the previous model to estimate the likelihood of default for a given ﬁrm. First, we elaborate on Eq. (2),

 = min {   } =  · I{ } +  · I{ ≥}
where I{E} is the indicator function, i.e. I{E} = 1 if the event E is true and I{E} = 0 if the event E is false. Second, we have,

0 = − E ( )









= − E  · I{ } +  · E I{ ≥}

= − [E ( | Default) Q (Default) +  · Q (Survival)]  (6)

where E ( | Default) is the expected assets value given the event of default, Q (Default) is the probability of default, and Q (Survival) = 1 − Q (Default) is the probability the ﬁrm does not default.
• Comparing Eq. (6) with Eq. (4) reveals that for the Merton’s model,

Q (Survival) = Φ (2) 

Chapter V - Conceptual approaches to valuation of defaultable securities

266

## Page 271

Probability of survival

1
0.95
0.9
0.85
0.8 0
1 0.9 0.8 0.7 0.6 0.5 0.4
0

5

10

15

20

25

30

Time-to-maturity (years)

1

Probability of survival

0.9

0.8

0.7

0.6

0.5

0.4

0.1

0.2

0.3

0.4

0

Assets volatility,

0.1

0.2

0.3

0.4

Assets volatility,

Probability of survival

Figure 4. Probability of survival Φ (2) against time to maturity (top panel) and assets volatility (bottom panels). Debt face value  = 100; safe rate  = 3%. Top panel : 0 = 110 and  = 010. Bottom left panel : Survival probs for maturities  = 05 years (top line),  = 1 and  = 2 years (bottom), and 0 = 110. Bottom right panel : Survival probs for 0 = 101. For suﬃciently high , survival prob rank as in the left panel; for small , ranking is reversed.

Chapter V - Conceptual approaches to valuation of defaultable securities

267

## Page 272

• Intuitively, when 0 ≈  , the probability of survival is

Q (Survival) = Φ (2) ,

with 2

=

ln


0 

+

 

−

21 2



√



≈

 

−

1 2

2

√ 





such that the survival probability still decreases in  for large  although then, it

increases in  for small .

• Summary statistics distance-to-default is formally deﬁned as,

ln


0 

+

 

−

1 2

2



2 =

√



(7)



• It is a very intuitive measure of how far the ﬁrm is from defaulting, as we know the

(risk-adjusted) probability of surviving is Φ (2), which is increasing in 2.

— The higher the current assets value 0 is, the less likely it is the ﬁrm will default at .

— Distance-to-default is decreasing in the assets volatility  — we saw this in Figure 4.

•

By Eq.

(1),

we

have

that

E

(ln

 |

0)

=

ln

0

+

(

−

1 2

2)

,

so

Eq.

(7) tells us

that distance-to-default is simply the diﬀerence E (ln  | 0) − ln , normalized

by the standard deviation of the assets over the life of debt.

• Some prefer to use the slightly diﬀerent formula,

Mkt value of Assets − Default value

Distance-to-default =



Mkt value of Assets ∗ Asset volatility

Chapter V - Conceptual approaches to valuation of defaultable securities

268

## Page 273

Loss-given-default, under Q

• Comparing Eq. (6) with Eq. (4) reveals another property of the Merton’s model,

E

( |

Default)

=

0 Φ (−1) Q (Default)

=

0

Φ Φ

(−1) (−2)

=

E ( )

Φ (−1) Φ (−2)

≤

E

( )



• Recovery rates are deﬁned as the fraction of the bond value the bondholders expect to obtain in the event of default, at maturity:

RR ≡ Recovery Rate = E ( | Default) = 0 Φ (−1)



 Φ (−2)

• Loss-given-default (LGD, in the sequel) is deﬁned as the fraction of the bond value the bondholders expect to lose in the event of default, at maturity:

LGD = 1 − RR

Chapter V - Conceptual approaches to valuation of defaultable securities

269

## Page 274

• Finally, by Eq. (5), we can write,

S0

=

1 −


ln



0 



Φ

(−1)

+

 Φ (2)

1

=

− 

ln

(RR

·

Q

(Default)

+

Q

(Survival))

1

≈  [LGD · Q (Default)] 

(8)

This is actually a general formula (that goes beyond the Merton’s model). It can easily be obtained through Eq. (6).

Chapter V - Conceptual approaches to valuation of defaultable securities

270

## Page 275

Under P!

• Important note –
— Survival probabilities, distance-to-default, loss-given-default, were previously deﬁned under the risk-adjusted probability Q.
• To calculate the same objects under the true probability P, we replace  with the asset growth rate under the physycal probability, , in the formulae for the survival probabilities, Φ (2), distance-to-default, 2, and loss-given-default.
— But it is hard to estimate  for many single names. • Moody’s KMV EDFTM are based on dynamic structural models like these, although
the details are not publicly known.
• Finally, we could use historical data about default frequencies to estimate the probability that a given single name within a certain industry will default. These frequencies are based on samples of ﬁrms that have defaulted in the past, with similar characteristics to those of the ﬁrm under evaluation (in terms, for instance, of distance-to-default).

Chapter V - Conceptual approaches to valuation of defaultable securities

271

## Page 276

One example

• Assume the assets value of a given ﬁrm is 0 = 110, and that the instantaneous volatility of the assets value growth is  = 30%, annualized. The safe interest rate is  = 2%, annualized, and the expected growth rate of the assets value is  = 5%, annualized. The ﬁrm has outstanding debt with nominal value  = 100, which expires in two years.

• First, we compute the distance-to-default implied by the Merton’s model, which is,

D-t-D =

ln


0 

+

 

−

1 2

2



√

=

 ln (11) + 002 −
√

1 2

032

2

= 010680



03 2

Accordingly, the probability of default is,

1 − Φ (010680) = 1 − 054253 = 045747

Chapter V - Conceptual approaches to valuation of defaultable securities

272

## Page 277

• We can compute the same probability, under the physical measure, by simply replacing

 = 2% with  = 5%, in the formula for D-t-D. We have,

ln


0 

+

 

−

1 2

2



D-t-Dphysical =

√



=

ln

(11)

+

 005 √

−

1 2

032

2

03 2

= 024822

• Therefore, the probability of default under the physical distribution is,

1 − Φphysical (024822) = 1 − 059802 = 040198
It is, of course, lower under the physical probability than under the risk-neutral probability.

Chapter V - Conceptual approaches to valuation of defaultable securities

273

## Page 278

• Finally, we can compute the spread on this bond, which is given by:

Spread

=

1 −


ln



0 



Φ

(−1)

+

 Φ (2)



√ where 2 = D-t-D, and 1 = 2 +   . So we have,

Spread

=

1 −

ln

 11002∗2Φ

 −

 010680

+

030

∗

√  2

+

Φ

 (010680)

2

=

1 −

ln

 11002∗2

∗

029769

+

 054253

2

= 620%

Chapter V - Conceptual approaches to valuation of defaultable securities

274

## Page 279

First passage

• The timing of default can be triggered by some exogeneously speciﬁed events.
— For example, default occurs if the value of the assets hits some exogenously lower bound even before the expiration of debt.
— These models are known as “ﬁrst passage” models, because they rely on mathematical techniques that solve for the probability the ﬁrst time the asset value hits some exogenous “barrier”, as in Black and Cox (1976).

Chapter V - Conceptual approaches to valuation of defaultable securities

275

## Page 280

Strategic defaulting

• The timing of default can be endogenous. Managers choose the defaulting barrier (i.e. the asset value that triggers bankruptcy) so as to maximize the ﬁrm’s value. Naturally, strategic defaulting works if the assumptions underlying the Modigliani-Miller theorem do not hold.
— The mechanism: On the one hand, debt is a tax-shielding device. On the other hand, issuing too much debt increases the likelihood of default, which triggers bankruptcy costs. The ﬁrst eﬀect raises the value of the ﬁrm while the second, decreases the value of the ﬁrm. Equity holders choose the value of the asset that triggers bankruptcy to maximize the value of equity. ∗ Leland (1994): Long-term debt ∗ Leland and Toft (1996): Extension to ﬁnite maturity debt ∗ Anderson and Sundaresan (1996): Debt re-negotiation
— The Appendix provides a succinct presentation of this approach, based on Leland (1994).

Chapter V - Conceptual approaches to valuation of defaultable securities

276

## Page 281

Pros and cons of structural approaches to risky debt assessment

• Pros
— Allows to think about more complicated structures or instruments easily (e.g., convertibles)
— Provides simple yet consistent relations between diﬀerent securities issued by the same name
— Very good for theoretical research in the 1990s
• Cons
— The ﬁrm’s asset value and asset volatility are not observed ∗ Must rely on calibration/estimation methods
— Bond prices generated by the model =6 market prices ∗ Traders can not use these models. Traders would require theoretical prices that exact match the market prices
— Sovereign issuers? — Most important. Structural models predict unrealistically low short-term spreads:
see, e.g., Figure 3. ∗ Intuition. Diﬀusion processes are smooth; hence, the probability of default tends
to zero maturity approaches, because default can not just jump in an unexpected way. This is not what we exactly observe. Jumps seem to be a more realistic device to modeling spreads.

Chapter V - Conceptual approaches to valuation of defaultable securities

277

## Page 282

V.3 Reduced form approaches: intensity models

• Aka “Rare events” models

Assumptions

• Default often displays a few strong characteristics: — It arrives unexpectedly — It’s rare — It causes discontinuous price changes
• The previous structural models do not accommodate for these features −→ diﬀusion processes are continuous: passage times are known, “locally”.
— This feature is responsible for the low short-term spreads.

Chapter V - Conceptual approaches to valuation of defaultable securities

278

## Page 283

Poisson processes

• Suppose to “count” the number of times some event happens. Denote with  the corresponding “counting process”.

Default time,
• Default time is simply deﬁned as 0, i.e. the ﬁrst time  “jumps”.

Chapter V - Conceptual approaches to valuation of defaultable securities

279

## Page 284

A few technical details

• Assume we chop a given interval [0  ] in  pieces, and consider each resulting

interval

∆

=

 

.

• Assume jump probability over each of these small intervals of time ∆ is proportional

to ∆, with proportionality factor equal to ,

 ≡ Pr {One jump over ∆} = ∆

(9)

• Assume the number of jumps over the  intervals follows a binomial distribution:

Pr { jumps over [0  ]} =  (1 − )− 

 where  =  





• For  large (or, equivalently, for small intervals ∆),

Pr {

jumps over

[0  ]} ≈

( ) 

 −

1−

≈

( ) − 

!



!

Chapter V - Conceptual approaches to valuation of defaultable securities

280

## Page 285

Applications to risky debt

• We can use the previous basic calculations to come up with a few fundamental properties for the distribution of default. We have,

Pr {Survival by  } = Pr {0 jumps over [0  ]} = −

Pr {Default by  } = Pr {at least one jump over [0  ]}

= 1 − Pr {Survival} = 1 − −

Pr {Default occurs at some } = −

Expected Time-to-Default =  ∞ − = 1

0



• We can now use these probabilities to assess the value of debt subject to default risk. Consider Eq. (6):

0 = − [Rec · Q (Default)+  · Q (Survival)]
≡0

where Rec is the expected recovery value of the asset. Using the probabilities predicted

by the Poisson model, we obtain:





0 = Rec · 1 − − +  · − 

(10)

Appendix B supplies an alternative derivation of Eq. (10).

Chapter V - Conceptual approaches to valuation of defaultable securities

281

## Page 286

Implications for spreads

• Let LGD denote loss-given-default. For small maturities  , we have approximatively,

that

Spread

=

1 −

ln 0 

≈

1 −

 0

 −1

=

1





1 − − · LGD.







• Note, for  small, the spread is not zero, as in the previous structural models. Rather, it is given by the expected default loss per period, deﬁned as the instantaneous probability of default times LGD,

Short-Term Spread =  · LGD.

• The next slide depicts the behavior of the spread predicted by the model at all

maturities, given by,

Spread = − 1 ln 0



=

−

1

Rec ln

·

 1

−

 −

+

 −







Chapter V - Conceptual approaches to valuation of defaultable securities

282

## Page 287

240 239 238 237 236 235 234 233 232 231 230
0

Spread (in basis points)

1

2

3

4

5

Time-to-maturity (years)

Figure 6. The term structure of spreads, in basis points, with recovery rate equal to 40% and intensity equal to  = 004, implying an expected time-to-default equal to −1 = 25 years.
• It’s decreasing in time-to-maturity. Eventually, as time to maturity gets large, the bond becomes certain to default, thus behaving as a bond without default risk–the bond is certain to deliver the recovery rate.

Chapter V - Conceptual approaches to valuation of defaultable securities

283

## Page 288

A simple model with random recovery

• Suppose that recovery value is not constant, but shrinks exponentially to zero as Rec ≡  · − , for two constants  and .

— Can be interpreted as follows

B Recovery rate =  if default occurs at  –but provided an hidden risk does not materialize that that the ﬁrm will not distribute any recovery value at all in case

of bankruptcy B Therefore, if this hidden risk is independent of bankruptcy, and Poisson intensity
, expected recovery is precisely Rec ≡  · − — Simple way to model stochastic recovery rates — Think of  as a “recovery dissipation rate”

• Then, asymptotically, the spread is



lim S0 ( ) =
 →∞

, if  ≥  , if  ≤ 

• So, now, spreads may well be increasing in time-to-maturity

Chapter V - Conceptual approaches to valuation of defaultable securities

284

## Page 289

Spread (in basis points)

320

310

300

290

280

270

260

250

240

230

0

2

4

6

8

10

12

14

16

18

20

Time-to-maturity (years)

Term structure of bond spreads implied by an intensity model with recovery rate equal to 040− , where  is time to maturity and  is the “recovery dissipation rate.” Param values  = 005 (solid line),  = 003 (dashed), and  = 0013 (dotted). Inst default prob  = 004, implying an expected time-to-default equal to −1 = 25 years.

Chapter V - Conceptual approaches to valuation of defaultable securities

285

## Page 290

Some issues

•  is the risk-neutral instantaneous probability of default, not the physical probability of default, ∗ say.
• The ratio ∗ is generally larger than one. Its inverse, ∗, is an indicator of the risk-appetite in the credit market.
• Similarly, LGD is an expectation under the risk-neutral probability, and should contain useful indications about market participants risk appetite.

Chapter V - Conceptual approaches to valuation of defaultable securities

286

## Page 291

One example

• Assume that under the risk-neutral probability, the instantaneous intensity of default for a given ﬁrm is  = 4%, annualized, and that under the physical probability, the instantaneous probability of default for the same ﬁrm is ∗ = 2%, annualized. From here, we can compute the probability of survival of the ﬁrm within 5 years, under both probabilities. They are:
−5 = −5∗004 = 081873 −5∗ = −5∗002 = 090484

Naturally, the probability of surivival is lower under the risk-neutral measure. • Next, assume that the spread on a 5 year bond with face value  = 1, equals 3%.
What is the implied expected recovery rate from this spread? We have,
0 = − [Rec · Q (Default) +  · Q (Survival)] = − [Rec ∗ (1 − 081873) + 1 ∗ 081873] 

The spread is,

1 Rec ∗ (1 − 081873) + 1 ∗ 081873

0

=

3%

=

− 5

ln

1



Solving for Rec, gives, Rec = 2316%.

Chapter V - Conceptual approaches to valuation of defaultable securities

287

## Page 292

V.4 Evaluation in continuous-time

• We may relax the assumption the instantaneous intensity of default, , is constant.

— This intensity is deﬁned under the risk-neutral probability and can change either because the intensity of default under the physical probability changes or because risk-appetite changes, or both.
— We aim to examine the asset pricing implications of time-varying intensities, by ﬁrst exploring how probabilities of survival change in a simple setting, where we do not single out the reasons leading to variations in .

• So assume that the default risk-neutral intensity, , is solution to:



=



¯

−

 



+

  

0 = 

where  is a standard Brownian motion under the risk-neutral probability, and , ¯ and  are three positive constants

• Formally, the same as Cox, Ingersoll and Ross (1985) model in Chapter II–used to

model dynamics of the short-term rate

• Under parameter restrictions,  is always positive, and it is possible to show that:

 



surv ( ) ≡ Pr {Surv at } = E − 0 () 

• Closed-form solution to surv ( )–same as Cox, Ingersoll and Ross! • Discussed in Chapter VI

Chapter V - Conceptual approaches to valuation of defaultable securities

288

## Page 293

V.5 Assessment based on ﬁrms ratings

• In practice, corporate debt is assessed by rating agencies such as Moodys and Standard

and Poors. Depending on the rating, corporate debt may be either investment grade

or non-investment grade (“junk”).

— Moodys rating go from Aaa to C

— Standard and Poor’s go from Aaa to D

• One can compute the probability of “migrations” based on past experience −→

Transition probabilities.

Example

From/to
AAA AA A BBB BB B CCC D

AAA 89.10 0.86 0.09 0.06 0.04
0 0 0

AA 9.63 90.10 2.91 0.43 0.22 0.19
0 0

A 0.78 7.47 88.94 6.56 0.79 0.31 1.16
0

BBB 0.19 0.99 6.49 84.27 7.19 0.66 1.16
0

BB 0.30 0.29 1.01 6.44 77.64 5.17 2.03
0

B 0 0.29 0.45 1.60 10.43 82.46 7.54 0

CCC 0 0 0
0.18 1.27 4.35 64.93
0

D 0 0 0.09 0.45 2.41 6.85 23.19 100

Table 1

Chapter V - Conceptual approaches to valuation of defaultable securities

289

## Page 294

Migrations

• A natural approach, then, is to assess credit risk by making reference to probabilities of default built up on transition probabilities like those in Table 1.
— This approach is somewhat less drastic than that based on rare events, and hopefully more realistic. However, it is also technically more complex than the intensity approach of the previous section.
• We provide the most foundational issues related to this approach, leaving some details in Appendix C.
— Assumptions/notation: ∗ At time , there exist several rating classes,  say, denoted as Rat,

Rat ∈ {1 2 · · ·  } 

∗ Transition probabilities of rating from time  to time  is,

 ( − ) ≡ Pr (Rat = | Rat = )    ≤ 

∗ We can build a Markov chain from here, by assuming that  ( − ) only depends on  − .
∗ Finally, we must have that,



 ( − ) ≥ 0 and

=1  ( − ) = 1

Chapter V - Conceptual approaches to valuation of defaultable securities

290

## Page 295

Some examples

• The probability of transition from rating Rat =  to rating Rat+1 =  in one year is,  (1)  Table 1 contains one possible example of  (1).
• The probability of transition from rating Rat =  to rating Rat+2 =  in two years is  (2), and is obtained as follows,

 



(2)

=

=1

Pr(transition

 (1)
from  to 

in

one

·
year) Pr(transition

 (1)
from  to  in

one

further

year)

• More generally, we have,

 ( ) =  (1) 

where  ( ) is the matrix with elements { ( )}. • The following slides provide numerical examples of these probabilities based on Table
1.

Chapter V - Conceptual approaches to valuation of defaultable securities

291

## Page 296

• The probability transition matrix  in Table 1 is,



891



= 

086 009 006 004
0 0

963 901 291 043 022 019
0

078 747 8894 656 079 031 116

019 099 649 8427 719 066 116

03 029 101 644 7764 517 203

00

0

0

0

0 029 045 16 1043 8246 754
0

0 0 0 018 127 435 6493 0



0

0 009 045 241 685 2319



100

• 2 year transition matrix:



794

 (2) ≈ 

15 01 01 0 0 0

1728 8148 524 096 044 035
0

0

0

212 1344 7975 1145 185 068 190
0

049 223 11346 7192 11778 154 201
0

054 064 213 1058 61316 841 337
0

0 058 098 338 1691 6887 1134
0

0 001
0 041 221 647 4251
0



0

0 025 114 532 1363 3881

 

100

Chapter V - Conceptual approaches to valuation of defaultable securities

292

## Page 297

• 15 year transition matrix:



2001

 (15) ≈ 

338 117 064 033 014
0

3582 3028 1312 676 322 165 108

0

0

2391 3271 3421 2221 1071 501 354
0

992 1591 2193 2240 13616 675 390
0

405 638 969 1242 1136 748 351
0

306 511 801 1193 1468 1317 560
0

043 077 129 209 278 264 122
0



266

534 1033 2139 4316 6304 8102



100

Chapter V - Conceptual approaches to valuation of defaultable securities

293

## Page 298

Another example

• Consider the following transition matrix:

To

A B Def

From

A B

0.9 0.07 0.03 0.15 0.75 0.10

Def 0

0

1

where Def denotes the state of default. What is the probability that a name A will

remain name A in two years? What is the probability that a name A will default in two

years?

• Consider the following two year transition matrix:

 090
Q (2) =  015
0

007 075
0



003

090

010   015

1

0

007 075
0

 003 010  
1

such that:

Pr {A is A in 2 years} = 09 ∗090 + (007)∗(015) + 003∗ 0

→→

→→

→ →

= 08205

Chapter V - Conceptual approaches to valuation of defaultable securities

294

## Page 299

and

Pr {A defaults in 2 years} = 09 ∗003 + (007)∗(010) + 003∗ 1

→→

→→

→ →

= 0064

• In general, we have that:

and for any  ,

 3 Q (2) = Q (1) · Q (1) 
=1

 090
Q ( ) = Q (1) =  015
0

007 075
0

003  010  
1

• Next, consider the following transition matrix, under the risk-neutral probability:

To

A B Def

From

A B

0.80 0.20 0 0.15 0.75 0.10

Def 0

0

1

Chapter V - Conceptual approaches to valuation of defaultable securities

295

## Page 300

• From here, we may easily compute, again, the (risk-neutral) probability A will default in two years, and the probability B will default in two years. We have,

 080
Q (2) =  015
0

020 075
0



0

080

010   015

1

0

020 075
0

 0 010  
1

such that:

Pr {A defaults in 2 years} = Q (2)13

= 08∗ 0 + (020)∗(010) + 0 ∗1

→→

→→

→ →

= 002

(multiply ﬁrst row by the third column), and,

Pr {B defaults in 2 years} = Q (2)23

= 015∗ 0 + (075)∗(010) + 010∗ 1

→→

→→

→ →

= 0175

(multiply second row by the third column).

Chapter V - Conceptual approaches to valuation of defaultable securities

296

## Page 301

• Finally, suppose that the bonds issued by both A and B mature in two years. Further,

assume that if these two bonds default, they pay oﬀ the same recovery rate, equal to

30%, and only at the end of the second period. From here, we can compute the credit

spreads for the two bonds. We have,

 ∗ Price A = (03) ∗ (002) + (1 − 002) = 0986

⇒

Spread

A

=

1 −

ln (0986)

=

70495 × 10−3

2

and,

 ∗ Price B = (03) ∗ (0175) + (1 − 0175) = 08775

⇒

Spread

B

=

1 −

ln (08775)

=

65339 × 10−2

2

Chapter V - Conceptual approaches to valuation of defaultable securities

297

## Page 302

Evaluation

• The previous probabilities, { ( )}, are meant to be taken under the physical world, not the risk-neutral world.
— They can be used for risk-management purposes, but certainly not for pricing. — Indeed, historical default rates are too low to explain the price of defaultable
securities. — A natural explanation relies on the presence of risk-premia.
• To use migration data for pricing, it is vital to implement a number of steps.
— Clean up the data – smoothing: ∗ For example, it might well be that downgrades from class  to class  + 2 are more frequent than downgrades from class  to class  + 1 ∗ Removing zero entries: although some rating event did not happen in the past, they might well occur in the future
— Add positive risk-premia to the previous smoothed data so as to obtain realistic asset prices.

Chapter V - Conceptual approaches to valuation of defaultable securities

298

## Page 303

Issues

• According to the migration model, there are  classes of assets. Each single asset may migrate from one class to another.

• Because evaluation is a dynamic business, we can not evaluate defaultable securities within a given asset class without simultaneously evaluate the defaultable securities in the remaining classes

— For example, there could be a chance that a given asset will “mutate” into a diﬀerent one in the next year.
— Given this, the price of this asset, today, must reﬂect the price of the asset in the other classes where it can possibly migrate.
— Hence, we must simultaneously solve for all the asset prices in all the rating classes — This approach, developed by Jarrow, Lando and Turnbull (1997), is quite complex
and is given a succinct account in Appendix C.

• Consider the simplest case, which arises when the expected recovery rate is zero. In

this case, by Eq. (6),

0 

=

−

(1

−

Q

(

−

)) 

where Q ( − ) is the risk-neutral probability the ﬁrm defaults, by time  , given it

belongs to rating  at time  .

Chapter V - Conceptual approaches to valuation of defaultable securities

299

## Page 304

• More generally, by Eq. (6),

0 

=

−

Rec  Q

(

−

)

+

(1

−

Q (

−

 )) 

The risk neutral probabilities, Q ( − ), must be found using migration frequencies such as those in Table 1, to which we must add appropriate risk-premia.

Chapter V - Conceptual approaches to valuation of defaultable securities

300

## Page 305

Strategic default (Leland, 1994)

Appendix A

• Debt: inﬁnite horizon, instantaneous coupon = . In the absence of default risk, debt would simply equal .

— Tax beneﬁts: proportional to the coupon,  

— Bankruptcy costs

∗ If the ﬁrm defaults at  = , recovery is (1 − )  ∗ Equity holders will choose . Naturally,   0

• Value of debt: a function of  , say  ( ). Under the risk-neutral probability, it satisﬁes:

 

E

[

( )| 

0]  =

+


=coupon

=



()



=Expected capital gains

By Itˆo’s lemma, this is an ordinary diﬀerential equation, subject to the following boundary conditions,

— At bankruptcy,  () = (1 − ) 

—

For

large

,

debt

is

substantially

riskless,

i.e.

lim →∞  ( )

=

 

.

The solution to this is,

  ( ) = (1 −  ( ))  +  [(1 − ) ] 

where



(

)

≡

  

 2
2



Note, we may interpret  ( ) as the present value of $1 contingent on future bankruptcy.

Chapter V - Conceptual approaches to valuation of defaultable securities

301

## Page 306

• Accordingly, — The total beneﬁts arising from tax shielding are,
   ( ) = (1 −  ( ))    — The present value of bankruptcy costs,

• We have,

 ( ) =  ( ) 

Value of the ﬁrm = Equity + Debt = Value of Assets ( ) +   ( ) −  ( )

Summing up,

  ( ) ≡ Equity =  − (1 −  ( )) (1 −  )  −  ( ) 

Equity 0 (

)hold=ersc=hoo0s,ea

 to maximize the value of smooth pasting condition. The

equity. The result is,

solution

is

to

ﬁnd



such

that





=

(1

− )



+

1 2

2



Chapter V - Conceptual approaches to valuation of defaultable securities

302

## Page 307

Alternative derivation of Eq. (10)

Appendix B

Under the risk-neutral probability, the expected change of any bond price must equal zero when the safe short-term rate is zero,

 () +  (Rec −  ()) =  = 0 with  ( ) = 


where

the

ﬁrst

term,

() 

,

reﬂects

the

change

in

the

bond

price

arising

from

the

mere

passage

of

time,

and  (Rec −  ()) is the expected change in the bond price, arising from the event of default, i.e. the

probability of a sudden default arrival, , times the consequent jump in the bond price, Rec −  ().

The solution to the previous equation is,



(0)

=


0

Rec

·

−
=Pr{Default

at


}

+

 − 

which is Eq. (10).

Chapter V - Conceptual approaches to valuation of defaultable securities

303

## Page 308

Appendix C
Some details on transition probability matrixes and pricing

Consider the matrix  ( − ) for  −  ≡ ∆,  (∆), and write,



 (∆) ≡

1 + ∆  ∆

=  6= 

(11)

We are deﬁning the constants  as they were the counterparts of the intensity of the Poisson process in Eq.

(9). Accordingly, these constants are simply interpreted as rating  to rating  over the time interval ∆. Naturally,

the for

einacsthan,tawneeohuasvperothbaatbi lities=o1fm(ig∆rat)ion

from = 1,

and using into Eq. (11), we obtain,

 

 = −   6= 

(12)

=1

The matrix Λ containing the elements  deﬁned in Eqs. (11) and (12) is called the generating matrix.

Next, let us rewrite Eq. (11) in matrix form,

 (∆) =  + Λ∆

Suppose

we

have

a

time

interval

[0  ],

which

we

chop

into



pieces,

so

to

have

∆

=

 

.

We

have,



( )

=



(∆)

=

 

+

 Λ







For large ,

 ( ) = exp (Λ ) 

Chapter V - Conceptual approaches to valuation of defaultable securities

304

## Page 309

the

matrix

exponential,

deﬁned

as,

exp

(Λ

)

≡

∞
=0

( Λ) !

.

To evaluate derivatives “written on states,” we proceed as follows. Suppose  is the price of derivative in state  ∈ {1 · · · }. Suppose the Markov chain is the only source of uncertainty relevant for the
evaluation of this derivative. Then,



=

  

+

[˜

−

]

where ˜ ∈ {1 · · · }, with the usual conditional probabilities. In words, the instantaneous change in the

derivative

value,

,

is

the

sum

of

two

components:

one,

 

,

related

to

the

mere

passage

of

time,

and

the other, [˜ − ], related to the discrete change arising from a change in the rating.

Suppose that  = 0. Then,



=

0

=



() 

=

 

+

  
=1

 

−

 

=

 

+

 
=6 

 

−

  

with the appropriate boundary conditions.

As an example, consider defaultable bonds. In this case, we may be looking for pricing functions having the following form,
 ( − ) =  ( − ) + 1 −  ( − )  and then solve for  ( − ), for all  ∈ {1 · · · }.

Chapter V - Conceptual approaches to valuation of defaultable securities

305

## Page 310

Chapter VI Credit-risk shifting derivatives and structured products

Chapter VI - Credit-risk shifting derivatives and structured products

306

## Page 311

Table of contents

VI.1 A crash description of the main credit derivatives

VI.2 Credit Default Swaps

VI.3 Collateralized Debt Obligations, Nth to Default

VI.4 Mortgage-backed securities

* Appendix: Gaussian copulae and CDO pricing

Chapter VI - Credit-risk shifting derivatives and structured products

307

## Page 312

VI.1 A crash description of the main credit derivatives

Introduction I: Total Return Swaps (TRS)

• In a total return swap, or TRS, one party (who owns some asset, the asset underlying the TRS) receives from the counterparty payments based on a mutually agreed rate,

either ﬁxed or variable, and makes payments to the counterparty based on the return of the underlying asset, which includes both the income it generates and any capital

gains.

— The underlying asset can be a loan, a bond, an equity index, or a basket of assets.

— The interest payments are typically based on the LIBOR plus a spread.

• While TRS are usually categorized as credit derivatives, they combine both market risk and credit risk.

— Example: Party A receives LIBOR + ﬁxed spread equal to 2%. Party B receives the

total return of the S&P 500 on a principal amount of $1 million. If LIBOR is 6% and the S&P 500 appreciates by 10%, A pays B 10% and B pays A 8%. By netting, A pays B $20,000, i.e. $1 million × (10% − 8%).

• The beneﬁts:

— Being long a TRS allows the party with the asset on the balance sheet to buy protection against loss in value.
— Shorting a TRS allows the counterparty to receive the payoﬀs guaranteed by the

asset without necessarily having to put it in the balance sheet. ∗ Hedge funds ﬁnd it quite convenient to short a TRS, as this allows them to place
large bets with a relatively small amount of collateral upfront.

Chapter VI - Credit-risk shifting derivatives and structured products

308

## Page 313

• The market for TRS is over-the-counter and market participants include institutions only such as:
— investment banks such as Goldman Sachs, JPMorganChase — commercial banks such as Bank of America and Sumitomo — mutual funds such as Prudential, Merrill Lynch Asset Management — hedge funds, funds of funds, private equity funds, pension funds (e.g., CalPers),
university endowments (e.g., Harvard, University of California) — credit card lenders such as American Express, MBNA/Bank of America — insurance companies such as AIG and State Farm — governments — non-governmental organizations such as the World Bank, Inter-American
Development Bank — home loan banks such as FHLB, Fannie Mae, Freddie Mac — Treasury departments of large multinational corporations such as Wal-Mart and
British Petroleum) — a variety of special purpose vehicles such as CDOs and real estate investment trusts

Chapter VI - Credit-risk shifting derivatives and structured products

309

## Page 314

Introduction II: Spread Options (SOs)

• In general, SOs are options written on the diﬀerence between two indexes.
— For example, let 1 ( ) and 2 ( ) be the prices of two assets at time  . The payoﬀ promised by a SO entered at some time    , might be max {1 ( ) − 2 ( ) −  0}, where  is the strike of the SO.
— A SO can be written on the spread between two rates of returns too.
• Importantly, a SO can be written on the spread between the yield of a corporate bond and the yield of a Treasury bond.
— Examples include: ∗ NOB spread (notes - bonds), which are spreads between maturities ∗ Spreads between quality levels, such as the TED spread (treasury bills Eurodollars) ∗ MOB spreads, which measure the diﬀerence between municipal bonds and treasury bonds. ∗ The deﬁnition of a SO has now been extended to include payoﬀs written as a linear combination of indexes, interest rates and yield.

Chapter VI - Credit-risk shifting derivatives and structured products

310

## Page 315

Introduction III: Credit spread options (CSOs)

• A reference security is selected and strike spread and maturity are set. The payoﬀ is based on whether the actual spot spread at the exercise date is over or under the spread on the reference security.

— The transaction may be either based on changes in a credit spread relative to a risk-free benchmark (e.g. LIBOR or U.S. Treasury) or changes in the relative spread between two credit instruments. It may an American or European option
— CSOs allow to hedge against or capitalize on changes in credit spreads.

• Example

— A US pension fund owns $50m of Italian bonds 6.875% of 9/23/2033. It is fundamentally bullish on Italy but is concerned about short-term spread widening in the Italian markets due to upcoming elections.
— The pension fund buys $50m of a spread option on the Italian bonds 6.875% of 9/23/2033 vs. the UST bonds 6.875% of 8/15/2035. ∗ The bond is currently trading at 1.10% spread to the UST.
— The investor pays 0.60% upfront for a European style option with a spread strike of 1.10%, exercisable in 3 months. ∗ If the option is in-the-money, the investor will be paid $50 ∗ (Italian bondUTS bond − ) ∗ , where  = 1035 is the duration of the Italian bonds.
— For 0.60% upfront, the pension fund has hedged its exposure to widening of Italian spreads beyond 1.10% for three months.

Chapter VI - Credit-risk shifting derivatives and structured products

311

## Page 316

Credit Default Swaps (CDS)

• A CDS contract provides protection against credit losses associated with a default on pre-speciﬁed referenced securities.
• The purchaser of a CDS contract exchanges the credit risk of the issuer of the referenced securities for the credit risk of the seller of the CDS contract, who is typically a highly-rated ﬁnancial institution.
• The purchaser agrees to pay to the seller a periodic fee until the maturity date of the contract or until a default event, as deﬁned in the credit conﬁrmation, has occurred. In return, the seller is bound to pay the credit purchaser a pre-speciﬁed amount or a pre-ﬁxed fraction of the value of the referenced security contingent upon the occurrence of a credit default.
• Typically, the amount payable by the seller is the diﬀerence between the actual market value of the defaulted security and the referenced security’s initial principal.
• The International Swaps and Derivatives Association (ISDA) provides a master credit conﬁrmation that is commonly used in most CDS contracts. According to this master agreement, a credit default is deﬁned to include a wide range of events, from bankruptcy, obligation acceleration, missed interest or principal payments, repudiation of payments to distressed exchanges or restructuring of securities.

Chapter VI - Credit-risk shifting derivatives and structured products

312

## Page 317

• Although most other credit events can be easily agreed upon by parties to a CDS contract, one exception is the restructuring criterion which typically involves renegotiation between the issuer and the majority of the holders of the referenced securities in a way that worsens the ﬁnancial position of the securities held.
• When a default event occurs, typically two settlement choices are available:
(i) A physical settlement, in which the buyer delivers the physical security while the seller pays the buyer the face value of the referenced security
(ii) A cash settlement, in which the seller simply settles the diﬀerence between the market value of the defaulted security and its face value.
• Physical settlement seems to be the prevalent choice even though the purchaser of a CDS contract is not required to hold the physical security when entering into the contract.
• CDS contracts are more liquid than most corporate bonds:
— They are more standardized than corporate bonds in so far as the credit events are clearly deﬁned in the ISDA credit derivatives deﬁnitions.
— CDS contracts allow to go long credit risk without a cash payment, as well as go short credit risk with less diﬃculty and at lower cost than with corporate bonds.
• A CDS index is contract that covers default risk on the pool of names in the index.
— CDS indices give the big picture of the state of credit markets, and will be discussed in more detail in Section VI.2.

Chapter VI - Credit-risk shifting derivatives and structured products

313

## Page 318

Collateralized debt obligations (CDOs)

• CDOs are securitized shares in pools of assets. The collateral assets comprise loans or debt instruments.
• A CDO may be called a collateralized loan obligation (CLO) or collateralized bond obligation (CBO) if it holds only loans or bonds, respectively.
• Investors bear the credit risk of the collateral. Multiple tranches of securities are issued by the CDO, oﬀering investors various maturity and credit risk characteristics.
• Tranches are categorized as senior, mezzanine, and subordinated/equity, according to their degree of credit risk.
• If there are defaults or the CDO’s collateral otherwise underperforms, scheduled payments to senior tranches take precedence over those of mezzanine tranches, and scheduled payments to mezzanine tranches take precedence over those to subordinated/equity tranches.
• Senior and mezzanine tranches are typically rated, with the former receiving ratings of A to AAA and the latter receiving ratings of B to BBB. The ratings reﬂect both the credit quality of underlying collateral as well as how much protection a given tranche is aﬀorded by tranches that are subordinate to it.
• As explained earlier, CDOs are part of a more general securitization process, and can also include mortgages, as in the example below.

Chapter VI - Credit-risk shifting derivatives and structured products

314

## Page 319

Some mechanics of CDOs

A stylized example on a CDO backed by Mortgage-Based Securities

— First step: Securitizing subprime mortgages

— Second step: Creating a CDO

— Third step: Creating seniority rules.

Chapter VI - Credit-risk shifting derivatives and structured products

315

## Page 320

• Investors in CDOs

— Senior tranches: banks, pension funds ﬁnd these instruments beneﬁt from

diversiﬁcation and expertise of the asset managers, with return-risk proﬁles

unavailable in the market.

— Junior tranches: hedge funds that want to invest in something very risky but at the

same time exceptionally rewarding and certainly unavailable in the market.

Very famous investors include Oﬀ-Balance-Sheets entities such as “SIV,”

“conduits,” and “SIV-lites,” which are (were) nothing but banks in a shadow

banking system.

∗ Analyzed in detail in the next chapter.

• Underwriters — Investment banks, typically. They work closely with the asset manager and create

the “right” debt/equity ratio, collateral quality tests, etc. They liase with law ﬁrms

and create the special purpose vehicle (possibly in some heaven tax system) that will

purchase the assets and issue the tranches, price the various tranches, and obviously

ﬁnd the investors. Fees to underwriters are very generous, due to the complexity of

the CDOs.

∗ According to Thomson Financial, top underwriters in 2006 were:

· Bear Sterns

· Merrill Lynch

· Wachovia

· Citigroup

· Deutsche Bank, Bank of America Securities

Chapter VI - Credit-risk shifting derivatives and structured products

316

## Page 321

• Other actors

— Trustee and collateral administrator are almost invariably the same thing. They distribute noteholder reports, check compliance and execute priority of payments.
— Accountants perform due diligence on the CDOs collateral pool, verifying for example credit ratings for each asset.
— Rating agencies–discussed later

• The economics behind structured ﬁnance

— An originator may have private information about the quality of certain assets and/or a comparative advantage in valuing these assets relative to other market participants. If the originator wishes to sell some of its assets, an adverse selection problem will arise: because investors do not know the true quality of the assets, they will demand a premium in order to purchase them or a market will fail to arise in the ﬁrst place.
— Originators, or arrangers, can overcome this problem by creating structured ﬁnance instruments.
— Pooling creates diversiﬁcation beneﬁts, whereas tranching allows risk-averse investors and those with less information about asset values to purchase senior tranches and be protected from default. In the process, the originator or arranger may retain subordinated exposure (i.e. to the ﬁrst losses in the pool) to alleviate investors’ concerns with incentive compatibility.
— Banks, for example, typically retain the equity tranches of the collateralized loan obligations that they issue.
— Alternatively, reputation - established through a proven track record - may help to align incentives.

Chapter VI - Credit-risk shifting derivatives and structured products

317

## Page 322

— In such an environment, a tranche rating can lower issuance costs by oﬀering an

independent assessment of the quality of the underlying assets and of the degree of

protection aﬀorded to senior tranche holders

Chapter VI - Credit-risk shifting derivatives and structured products

318

## Page 323

To summarize

Chapter VI - Credit-risk shifting derivatives and structured products

319

## Page 324

Types of CDOs

• In practice, CDOs are considerably more complex than the stylized example outlined earlier. We have a number of cases.
— A CDO is static, if it holds the same set of assets — A CDO is managed, if the asset manager is allowed to change the composition of
assets — If the claims to the CDO arise from the cash ﬂows originated by the assets, we have
a cash-ﬂow CDO — If the claims to the CDO arise from the cash ﬂows originated by the assets and/or
active asset management, we have a market-value CDO — CDOs can also be created to carve out balance sheets, in which case we have
balance-sheet CDOs — Interestingly, CDOs can be created,
∗ to achieve investment grade bonds through a pool of noninvestment grade bonds ∗ to create riskier securities than those in the asset pool In these cases, we have arbitrage CDOs. Naturally, “arbitrage” CDOs do not give rise to any arbitrage opportunity. — Typically, arbitrage CDOs diﬀer from balance sheet CDOs, because of course, issuers of arbitrage CDOs do not necessarily hold the underlying collateral in advance, which is obviously the case for issuers of balance-sheet CDOs. Therefore, the assets to be put into the an arbitrage CDO pool have to be reasonably liquid.

Chapter VI - Credit-risk shifting derivatives and structured products

320

## Page 325

— Synthetic CDOs are exposed to a pool of assets that are not strictly owned or in the asset pool, typically through CDS underwriting. ∗ Like a cash-ﬂow CDO, the vehicle receives payments (the premium), which is then transferred to the tranche holders. Naturally, there can be default events, which are also passed through to the investors, according to the prespeciﬁed seniority rules. ∗ A synthetic CDO is funded, if the relevant tranche holders are to pay for in the case of a credit event related to the assets the CDO is exposed to. Typically, some funding is made available at the very time of investment. At maturity, the investor receives a payoﬀ equal to the funding minus the realized losses. · Junior tranches are typically funded, and senior are typically not. However, senior tranches investors might have to make payments in the unlikely event losses had ever to erode their tranches. ∗ In 2006, funded synthetic issuance was more than $80bn.
— Hybrid CDOs are partly cash-ﬂow CDOs and partly synthetic CDOs — In a single-tranche CDO, the entire CDO is structured to accommodate the speciﬁc
needs of a small group of investors, with some remaining tranche held by the dealer — CDO2: A large portion of the assets in the pool are tranches from other CDOs — CDOn: ... — Only in 2006, $200bn in mezzanine CDOs were issued, with 70% exposure to
subprime bonds

Chapter VI - Credit-risk shifting derivatives and structured products

321

## Page 326

The role of rating agencies

• Since the beginning, structured ﬁnance has largely been a “rated” market. Issuers of structured instruments apparently wanted them to be rated according to scales that were identical to those for bonds, so that investors, some of whom were bound by the ratings-based constraints deﬁned by their investment mandates, would be able and willing to purchase the new products.
• The rating agencies aim to provide independent opinions about the credit risk embodied in debt instruments, with some diﬀerences:
— With structured ﬁnance transactions, the rating agencies are to be involved in the deal’s structuring process. This is not required with traditional instruments.
— This is because a tranche rating reﬂects a judgment about both the credit quality of the underlying collateral asset pool and the extent of credit support that must be provided through the transaction’s structure in order for the tranche to receive the rating targeted by the deal’s arrangers.
— Deal origination thus involves obtaining implicit structuring advice by the rating agencies, at least to the extent that arrangers use rating agency models to prestructure deals and subsequently engage in an iterative dialogue with the agencies in order to ﬁnalize these structures. As a result, ratings of structured ﬁnance instruments have a decidedly ex ante character. This contrasts with traditional bond ratings, where pre-rating discussions between issuers and agencies play a more limited role.

Chapter VI - Credit-risk shifting derivatives and structured products

322

## Page 327

VI.2 Credit Default Swaps

• CDS diﬀer from TRS insofar as they provide protection against a credit event.

— TRS, instead, provide protection against a loss in asset value, which is often triggered by market risk

• The premium, assumed to be paid quarterly, on a CDS contract at time , is obtained

by equating the expected discounted value of the premium paid over the life of the

contract,

i.e.

at

dates





1



2



···



 ,

where



=

+

 4

,



=

4 · ,

and

 is the number of years the CDS refers to,

Premium =  4· −(−) · CDS ( ) Pr {Survival at } 
=1
to the expected discounted value of the protection,

Protection =  4· −(−) · LGD () Pr {Default ∈ (−1 )} 
=1

where  is the (constant) risk free rate, CDS () is the premium paid every quarter, prevailing at time , and LGD () is the Loss-Given-Default at time , which for simplicity is assumed to be constant, i.e. known at time .

Chapter VI - Credit-risk shifting derivatives and structured products

323

## Page 328

• Equating Premium and Protection, and solving for CDS, leaves:

CDS

( )

=

4·
=1

−(−) · LGD () Pr {Default ∈ (−1

4·
=1

−(−)

·

Pr

{Survival

at

}

)}

(1)

This is a general formula we can use, once we have a model determining the probability

of default under the risk-neutral probability.

• Using a reduced-form approach, we can ﬁnd quite easily the quarterly premium (or

spread) CDS (). We have, denoting again with  the instantaneous probability of

default,

— Pr {Survival at } = −(−)–from Chapter V. — Pr {Default at any  ∈ (−1 )} = −(−1−) − −(−).

∗ Intuitively, if the name survives at  (event ), it must necessarily have survived at −1 (event −1), but the converse is not true:  ⊂ −1, and the

complement of  to −1 is nothing but the event of default between −1 and

.

∗

Ma−th1 ePmra{tiDcaelflay,ult

we have at } ,

that where

Pr {Default at any  ∈ (−1 )} = Pr {Default at } = −(−) from

Chapter V.

Chapter VI - Credit-risk shifting derivatives and structured products

324

## Page 329

• Substituting the previous probabilities into the expressions for Premium and Protection,

CDS

( )

=

4·
=1
4·
=1

−(−) · LGD () Pr {Default ∈ (−1 )}

4·
=1

−(−)

·

Pr {Survival 

at

}



−(−) · LGD () −(−1−) − −(−)

=

4·
=1

−(+)(−)



• For example, if LGD () is constant and equal to LGD for each , then, for

∆

=



−

−1

=

1 4

,

CDS () ≈  · LGD · ∆ ≡ (expected losses per unit of time) · ∆ (2)

where the approximation is obtained by making −(−1−) − −(−) ≈ −(−)∆. Naturally,  is the risk-neutral instantaneous probability of default for
the security.

Chapter VI - Credit-risk shifting derivatives and structured products

325

## Page 330

• Note, Eq. (2) shows that the CDS premium is approximately the same as the instantaneous spread of a defaultable bond (see Chapter V).
— This is quite natural, as a purchase of a defaultable bond and protection on it is nothing but a synthetic default-free bond. Therefore, there must be a no-arbitrage relation between CDS spreads and defaultable bond spreads.
— In general, Eq. (2) does not hold, as the assumptions made to achieve it ( is constant, LGD is constant,  is constant, etc.) are quite unrealistic. ∗ On the contrary, we often observe CDS spreads curves that increase with maturity. ∗ Indeed, we may take interesting views. For example, buying CDS for 2Y and sell CDS for 3Y is a view that default will not occur between the second and the third year from now.

Chapter VI - Credit-risk shifting derivatives and structured products

326

## Page 331

Upfronts

• Market conventions now require upfront payments • I won’t deal with this complication in this edition of my lectures

Chapter VI - Credit-risk shifting derivatives and structured products

327

## Page 332

Credit default swap (CDS) indices

• A CDS index is a basket of credit entities.
— The protection buyer pays the same premium on all the names in the index. — Credit events are conﬁned to bankruptcy or failure to pay. — After a credit event, the entity is removed from the index and the contract continues
(with a reduced notional amount) until maturity.
• Why do we need this complication?
— Banks are exposed to macroeconomic risks through the loans on their balance sheet — A bank may be a protection buyer on a CDS index that comprises names correlating
with these macroeconomic risks — Hedge funds may provide insurance while being on the other side of the deal.
• Credit products are typically over-the-counter
— CDS on single names are mostly illiquid — CDS indices are standardized and can be more liquid–as historical data on bid-ask
spreads show. =⇒ It can be cheaper to hedge a portfolio of CDS or bonds with a CDS index than it
would be to buy many CDS to achieve a similar eﬀect. — Two main indices
∗ CDX index, which contains North American and Emerging Market companies ∗ iTraxx index, which contains companies from the rest of the world ∗ Plus you have Investment Grade and High Yield

Chapter VI - Credit-risk shifting derivatives and structured products

328

## Page 333

CDS Indices .....

[Figure, in progress]

Chapter VI - Credit-risk shifting derivatives and structured products

329

## Page 334

...... and credit volatility (Cboe & S&P)–mentioned in Chapter IV

1500
1000
500
0 2014

1000 800 600 400 200 0

2014

Credit Volatility - One-Month (U.S.) High Yield (VIXHY) and Investment Grade (VIXIG)

VIXHY VIXIG

2016

2018

2020

2022

Credit Volatility - One-Month (Europe) High Yield (VIXXO) and Investment Grade (VIXIE)

2024
VIXXO VIXIE

2016

2018

2020

2022

2024

Chapter VI - Credit-risk shifting derivatives and structured products

330

## Page 335

Disentangling default probability from risk-aversion

Source: Fender and H¨ordahl (2007).

Chapter VI - Credit-risk shifting derivatives and structured products

331

## Page 336

How did they estimate the price of risk?

• Consider the expected losses under the actuarial, or physical probability for a given security. The counterpart to Eq. (2), under the physical probability, is:
Expected Losses ≡  · LGD · ∆
where  is the physical instantaneous probability of default for a given security. — Assume that LGD is constant, to simplify. • If the investors require compensation for the default event, then, the actuarial losses should be less than the CDS spread, i.e. Expected Losses  CDS, or,
   

— The risk-premium is deﬁned as the diﬀerence between the actuarial losses, Expected Losses , and the CDS premium,





Risk-Premium =  −  · LGD · ∆

— The price of risk is deﬁned as the ratio of the CDS spread over the
Expected Losses , 
Price-of-Risk =  

Chapter VI - Credit-risk shifting derivatives and structured products

332

## Page 337

• Early references to estimation methods are Duﬃe et al. (2005) and Amato (2005). Typically, Expected Losses are proxied by Moody’s KMV’s Expected Default Frequencies (EDFsTM), obtained through fully speciﬁed structural models for credit risk.
— The next pictures are taken from Amato (2005) — As we can see, during the 2003-2005 period, credit spreads were so low, and this in
turn gave incentives to CDO issuers to look for illiquid and relatively more complex assets to put as collateral, which led to the issuance of CDO relying on ABS such as MBS, or CDO2, explained below.

Chapter VI - Credit-risk shifting derivatives and structured products

333

## Page 338

Chapter VI - Credit-risk shifting derivatives and structured products

334

## Page 339

The big picture

Valuation of Financial Instruments Based on Implied Probability of Default. Source: IMF, Global Financial Stability Report, April 2008.

Chapter VI - Credit-risk shifting derivatives and structured products

335

## Page 340

Continuous time

• Consider the continuous-time model introduced in Chapter V, where the instantaneous risk-neutral probability of default, , satisﬁes



=



¯

−

 



+

  

0 = 

(3)

Probability of survival is   
surv (  ) = E − 0  

where E (·) denotes the expectation under the risk neutral probability. Note that this is the same as the price of a zero coupon bond under the Cox-Ingersoll-Ross model (see
Chapter 4). Accordingly, we have

surv (  ) = Φ ( ) −()



2

1 2

(+)

 22¯

Φ () =

 () =

2

(+−)1(

− 1) 

+ 2 
 = 2

+

22

( + ) ( − 1) + 2

Chapter VI - Credit-risk shifting derivatives and structured products

336

## Page 341

• More generally, we can build up a whole family of models with a closed-form solution,

the aﬃne class reviewed in Chapter IV, by just assuming that:

 = 0 + 1 · 

where 0 is a constant, 1 is a vector of constants, and  is a multivariate aﬃne jump-diﬀusion process.
• This model is interesting, as we can judiciously choose the components of  () which we suppose may aﬀect the default intensity. For example, some of them could be unobservable, and other could be observable, and relate for example to the business cycle or even the structure of the ﬁrm.
• So given any solution for the survival probability predicted by any of these aﬃne models when  (0) = , surv ( ) say, we can easily compute

Pr{Default ∈ (−1 )} = surv ( −1) − surv ( ) 

We can then look at the bond spreads and the CDS spreads implied by this modeling choice. It is possible to show that the price of a defaultable pure discount bond expiring in  years is:



(

)

=

− surv

(

)

+


0

−

Pr{Default

∈

}Rec

()



where Rec () denotes the recovery value in case of default, supposed to be known.

Chapter VI - Credit-risk shifting derivatives and structured products

337

## Page 342

• As for the CDS spreads, we have, by Eq. (1),

CDS

( )

=

4
=1

−(−)LGD () Pr{Default ∈ (−1

4·
=1

−(−)

Pr{Survival

at

}

)}

=

4
=1

−(−)LGD () [surv (

4
=1

−(−)surv

−1) − ( )

surv

( )]

Chapter VI - Credit-risk shifting derivatives and structured products

338

## Page 343

• Assume the short-term rate, , is zero, and that loss-given-default is constant and equal to LGD. Then, it is possible to show that:

 (  ) = 1 − LGD · (1 − surv (  )) CDS0 ( ) = LGD · 1 −4=1susruvrv(( ))

where  is, again, the number of years the CDS refers to, and  =  + 4 .

•

The

picture

in

the

next

slide

depicts

the

bonds

spread,

−1 

ln

(

(

 )),

and

the

annualized credit spread, 4 × CDS0 (), when the parameters in Eq. (3) are

 = 030, ¯ = 004 and  =

1 2

¯,

with

LGD

=

060,

and

two

values

of

the

current intensity:  = ¯ (left picture) and  = 002 (right).

Chapter VI - Credit-risk shifting derivatives and structured products

339

## Page 344

Spreads (in basis points) Spreads (in basis points)

Average default intensity 245

240

235

230

225

220

215

210
205 0

bond spreads CDS spreads, annualized

2

4

6

8

10

Time-to-maturity (years)

Low default intensity 200

190

180

170

160

150

140

130
120 0

bond spreads CDS spreads, annualized

2

4

6

8

10

Time-to-maturity (years)

Spreads on bonds and CDS predicted by the aﬃne model (3). The left panel depicts the spreads when the current default intensity equals the long-run mean,  = ¯ = 004. The right panel depicts the spreads in good times, i.e., when the current intensity of default takes a low value,  = 002.
The mechanism is that good times are followed by bad times, and so when  = 002, we expect default rates to rise in the future. As a consequence, spreads are increasing in maturity.

Chapter VI - Credit-risk shifting derivatives and structured products

340

## Page 345

VI.3 Collateralized Debt Obligations

Collateralized Debt Obligations (CDOs)

• We’ve already seen that CDOs repackage cash ﬂows from a set of assets.
— We now proceed with providing simple examples showing how CDOs work, in practice.
— We begin with one example presented in McDonald (2006, p. 583), which we further elaborate here.
• Suppose we have three one-year bonds with face value = 100.
— For each of these bonds, the risk-neutral probabilities of default equal 10% and the recovery rates are 40.
— The safe interest rate for one year is 6%. — So by the usual evaluation methods, each bond price equals,

 = −006 · ( 010 · 40 + 090 · 100) = 88526

≡Def Prob

≡Surv Prob

— The yield is,

 − ln = 1219%
100

Chapter VI - Credit-risk shifting derivatives and structured products

341

## Page 346

• A CDO can restructure the payments promised by the three bonds in a way that transforms the riskiness and attractiveness of the initial assets.
• Consider the following example:

Asset pool

CDO claims

Face Value = 300

Senior tranche Mezzanine tranche Junior tranche

= 140 = 90 = 70

In this example, each tranche receives the minimum between (i) the nominal value claimed by the tranche and (ii) what is left available to the tranche after having satisﬁed the other tranches by order of seniority.

Chapter VI - Credit-risk shifting derivatives and structured products

342

## Page 347

• Let  be the nominal values claimed by the tranches, so that 1 = 140, 2 = 90 and 3 = 70.
• Let ˜ be the realized payoﬀ of the asset pool, deﬁned as,

˜ = No of Defaults · 40 + (3 − No of Defaults) · 100
≡No of surviving bonds
Naturally, ˜ is random because the number of defaults is random. • At the expiration,
— The senior tranches receives the minimum between 1 and ˜. For example, if only one bond defaults, ˜ = 240, and the senior tranche receives 140. If, however, three bonds default, then, ˜ = 120, which is less than the nominal value, and the senior tranche receives 120. So a quite severe loss is needed to erode the senior tranche claims.
— The mezzanine tranche receives the minimum between 2 and the “left-over” from the senior tranche. Finally, at the expiration, the junior tranche reveives the minimum between 3 and the “left-over” from the senior and mezzanine tranches.

Chapter VI - Credit-risk shifting derivatives and structured products

343

## Page 348

• More generally, tranche no.  receives,

 = min {Left-over from previous tranches up to tranche  − 1  } 

where



−1



Left-over from previous tranches up to tranche −1 = max ˜ −  0 

=1

• Synthetically,





−1



 = min max ˜ −  0   

=1

• All we need, now, is to model the risk-neutral probability of default for each ﬁrm.

• Initially, we assume the default events are independent across ﬁrms.

• Assume binomial distribution,

Pr (No of Defaults = ) = 3 (1 − )−   = 10%  ∈ {1 2 3}  

Chapter VI - Credit-risk shifting derivatives and structured products

344

## Page 349

• We can then derive the following payoﬀ structure

Payoﬀs to CDO tranches and prices (w/ independent defaults)

defaults 0 1 2 3

Pr(defaults) 0.729 0.243 0.027 0.001

Pool payoﬀ ˜ 300 240 180 120

Price Yield

Senior 1 140 140 140 120
131.82 0.0601

Mezzanine 2 90 90 40 0
83.40 0.0761

Junior 3 70 10 0 0
50.34 0.329





Notes: Pool payoﬀ is ˜ = N  × 40 + 3 − N  × 100, and face values of tranches are 1 = 140

(Senior), 2 = 90 (Mezzanine), and 3 = 70 (Junior).

• The price of each tranche is computed as the tranche payoﬀ, averaged across states,

discounted at the safe interest rate.

— For example, the price of the mezzanine tranche is,

Price Mezzanine = −006 (0729 ∗ 90 + 0243 ∗ 90 + 0027 ∗ 40 + 0001 ∗ 0) = 83403

Its yield is,

83403

Yield Mezzanine = − ln

= 761%

90

Chapter VI - Credit-risk shifting derivatives and structured products

345

## Page 350

• Naturally, the sum of the three bond prices, 88526 × 3 = 26558, is equal to the

total value of the three tranches, 131828 + 83403 + 50347 = 26558.

— A CDO is a mere re-packaging device. It doesn’t add or destroy value. It merely

redistributes risks.

• What happens if the default events are perfectly correlated? In this case, either the

three ﬁrms all default (with probability 0.10) or none defaults (with probability 0.90),

and we have the situation summarized below,

Payoﬀs to CDO tranches and prices (w/ perfectly correlated defaults)

defaults 0 1 2 3

Pr(defaults) 0.9 0 0 0.1

Pool payoﬀ ˜ 300 na na 120

Price Yield

Senior 1 140 na na 120
129.96 0.074

Mezzanine 2 90 na na 0
76.28 0.165

Junior 3 70 na na 0
59.33 0.165





Notes: Pool payoﬀ is ˜ = N  × 40 + 3 − N  × 100, and face values of tranches are

1 = 140 (Senior), 2 = 90 (Mezzanine), and 3 = 70 (Junior).

• Note, now, that mezzanine and subordinated tranches yields the same as they each pay oﬀ either their nominal value or zero in exactly the same states of nature.

Chapter VI - Credit-risk shifting derivatives and structured products

346

## Page 351

• The previous cases (with independent and perfectly correlated defaults) are extreme. It is by far more relevant to see what happens when defaults are only imperfectly correlated.
• When defaults are imperfectly correlated, there are no simple tables to use to come up with tranche pricing. Instead, one might make use of simulations, described succinctly in the Appendix.
• Figure 1 below, obtained through Monte Carlo simulations (described in the Appendix), illustrates how the yield on each tranche changes as a result of a change in the default correlation underlying the assets in the CDO.

Chapter VI - Credit-risk shifting derivatives and structured products

347

## Page 352

Yield

0.35 0.3

Yields on CDO tranches

Junior Mezzanine Senior

0.25

0.2

0.15

0.1

0.05

0

0.1

0.2

0.3

0.4

0.5

0.6

0.7

0.8

0.9

1

default correlation

Figure 1. Yields on the three CDO tranches, as functions of the default correlation among the assets in the structure

Chapter VI - Credit-risk shifting derivatives and structured products

348

## Page 353

“Arbitrage” CDOs

• The previous picture illustrates how arbitrage CDOs work.
— The CDO has three assets yielding the same, 12.19% (the horizontal, black line in Figure 1).
— However, by restructuring the asset base through a CDO, we can create claims (Senior and Mezzanine tranches) that yield less than 12.19%, as they are considerably less risky than the asset base.
— Such an excess return, (1219% − Yieldtranche), with Yieldtranche ∈ {Senior Mezzanine}, is “made available” to the subordinated tranche/equity holders, once we account for management fees and expenses.
— Note, the previous redistribution of risk always works when the default correlation is relatively low. ∗ As the default correlation in the asset base increases, the situation may change dramatically.

Chapter VI - Credit-risk shifting derivatives and structured products

349

## Page 354

Correlation assumptions

• In Figure 1, the subordinate yield decreases with default correlation. This happens because we are assuming that the probability of default is ﬁxed at  = 10% for each default correlation  (say).
— As  increases, the probability of clustering events increases, which makes the Senior and Mezzanine tranches relatively less valuable and, correspondingly, the Subordinate tranches more valuable.
• A more appropriate model is one in which  increases as  increases, to capture the fact that in bad times, both default correlation and probability of defaults increase as these two things are intimately related (by, e.g., some common business cycle factor).

Chapter VI - Credit-risk shifting derivatives and structured products

350

## Page 355

Some comparative statics: with  = 20% (instead of  = 10%)

Yield

Yields on CDO tranches 0.7
Junior Mezzanine Senior 0.6

0.5

0.4

0.3

0.2

0.1

0

0

0.1

0.2

0.3

0.4

0.5

0.6

0.7

0.8

0.9

1

default correlation

Figure 2. Yields on the three CDO tranches, as functions of the default correlation among the assets in the structure, with probability of default for each name equal to 20%.

The yields are obviously larger for each tranche.

Chapter VI - Credit-risk shifting derivatives and structured products

351

## Page 356

Addressing the correlation assumption

• Relax the assumption that the probability of default, , and the default correlation,  are independent. For simplicity, assume that  = 38 ∗ ln ( + 1).

— The situation, then, changes dramatically. Modeling matters a lot.

Yield

Yields on CDO tranches 0.5

0.45 0.4

Junior Mezzanine Senior

0.35

0.3

0.25

0.2

0.15

0.1

0.05

0.4

0.5

0.6

0.7

0.8

0.9

1

default correlation

Figure 3. Yields on the three CDO tranches, as functions of the default correlation among the assets in the structure, with probability of default and default correlation related by  = 38 ∗ ln ( + 1).

Chapter VI - Credit-risk shifting derivatives and structured products

352

## Page 357

A variation on theme: Nth to default

• In this contract, the owner of the 1st to default bears the risk of the ﬁrst default that occurs in the asset pool. — Payoﬀ = Pr (No of Defaults ≥ 1) ∗ 40 + Pr (No of Defaults  1) ∗ 100
• Likewise, the owner of the 2nd to default bears the risk of the second default that occurs in the asset pool. — Payoﬀ = Pr (No of Defaults ≥ 2) ∗ 40 + Pr (No of Defaults  2) ∗ 100
• Finally, the owner of the 3rd to default bears the risk of the third default that occurs in the asset pool. — Payoﬀ = Pr (No of Defaults = 3) ∗ 40 + Pr (No of Defaults  3) ∗ 100
• Let us assume that default correlation is zero for simplicity.

Chapter VI - Credit-risk shifting derivatives and structured products

353

## Page 358

• We have previously computed the previous probabilities as:
— Pr (No of Defaults ≥ 1) = 0243 + 0027 + 0001 = 0271 — Pr (No of Defaults ≥ 2) = 0027 + 0001 = 0028 — Pr (No of Defaults = 3) = 0001
• Thus we have the following prices, — 1st-to-default price = −006 ∗ [0271 ∗ 40 + (1 − 0271) ∗ 100] = 78863 — 2nd-to-default price = −006 ∗ [0028 ∗ 40 + (1 − 0028) ∗ 100] = 92594 — 3rd-to-default price = −006 ∗ [0001 ∗ 40 + (1 − 0001) ∗ 100] = 94120
• From here, we can compute the yields as follows,
— Yield (1st-to-def) = − ln (78863100) = 2374% — Yield (2nd-to-def) = − ln (92594100) = 769% — Yield (3rd-to-def) = − ln (94120100) = 606%

Chapter VI - Credit-risk shifting derivatives and structured products

354

## Page 359

VI.4 Mortgage-backed securities

• This section examines some basic details related to securitization processes induced by mortgages.
— Mortgages are secured loans as the family typically pledges the home as collateral. In the US, the typical maturity date can be equal to 15 or 30 years.
— The lender is typically a bank, a mortgage banker or more generally a ﬁnancial institution
— Every month, the homeowner pays an amount, which is credited toward the payment of interest and the outstanding principal amount that has been borrowed.
• A portfolio of mortgage loans is risky for a variety of reasons.
— Timing risk. — Interest rate risk, or duration mismatch, as the duration of these loans is much higher
than the liabilities. Mortgage rates are typically at spread of long-term interest rates, and the cost of funds is related to the level of the short-term interest rates. ∗ Great risk if the yield curve inverts. — These risks can be reduced through securitization (mortgage-backed securities), asset-liability management, interest rate derivatives, issuance of adjustable-rate mortgages

Chapter VI - Credit-risk shifting derivatives and structured products

355

## Page 360

Primary mortgage market

• After reviewing applications, the lender underwrites the loan, after the payment of an origination fee, which is typically very tiny (e.g., 1% of the loan). The criteria to provide funds to the borrower are based on:
— Information about the borrower’s credit history and other loans and liabilities. A rule of thumb could be that the mortgage payments be less than 30% of the borrower’s pretax monthly income.
— Information about the borrower’s net worth and liquidity — An assessment of the value of the property, with a policy limit set on the loan-to-
value (LTV) ratio. Typically the LTV ∈ [75% 95%].
• To ensure orderly payments on the loans, there are several forms of insurance programs. For example, if the LTV  80%, then, lenders will require the borrowers to purchase private mortgage insurance.
— Government agencies, such as the Federal Housing Administration (FHA) and the Veteran Administration (VA), provide mortgage insurance, which is intended to cover low-income and middle-income families.
— When private insurance is taken by the lender, the cost is passed on the borrower through a higher borrowing rate.

Chapter VI - Credit-risk shifting derivatives and structured products

356

## Page 361

The UK market and the stability of the housing market

• In the UK market, mortgages are obtained for long maturities. However, mortgage bankers give homeowners strong incentives to either renegotiate the loan or reﬁnance the loan with competing mortgage bankers after a period of 2-5 years from origination. (The incentives stem from the presence of a sizeable increase in the monthly payments after the period of 2-5 years from origination.)
— These incentives can lead to instability. Indeed, in bad times, the LTV increases, and the probability to renew the mortgage at sensible conditions decreases for any homeowner. This can lead a sizeable proportion of homeowners to sell the house as soon as possible, i.e. before the market value of the house becomes less than the value of the original mortgage.
— This makes the housing prices decrease further, with an additional proportion of homeowners selling the house, etc.
• Another channel:
— Falling house prices lead some borrowers to default — Foreclosures — House prices decrease further, hitting those banks that hold mortgage-based
securities, and causing them to pull back and freeze credit — Economic slowdown — Falling house prices, etc.

Chapter VI - Credit-risk shifting derivatives and structured products

357

## Page 362

Fixed-rate mortgages (FRMs) and Adjustable-rate mortgages (ARMs)

• FRMs pay monthly cash ﬂows, and are typically amortizing. Let 0 denote the original

loan and  denote the monthly payments. Let  be the original term of the loan, in

months.

Finally,

let



be

the

annualized

mortgage

rate

of

return,

and



=

 12

be

the

monthly mortgage rate of return. Then, 0,  and  satisfy,

0 (1 + )+1 =    · (1 + ) 
=1

or by rearranging terms,

(1 + )+1

 (1 + )



=

0 
=1

(1

+

)

=

0 (1

+

)

−

 1

Let  be the outstanding balance at the end of month , after that month’s payments have been made. We have,

 = −1 +  · −1 − 

(4)

Hence,
— The principal payments are −1 − . The interest payments are  · −1 — Then, in the early part of the life of the mortgage, most of the payments  are
applied toward repaying the interest rate component of the loan.

Chapter VI - Credit-risk shifting derivatives and structured products

358

## Page 363

• ARMs permit the interest payments to be reset at periodic intervals to prespeciﬁed short-term interest rates. They cover approximately 50% of the US market.
— Interest rate risk is shifted to the borrowers. Therefore, asset-liability management issues are mitigated, although they still exist in the period between the resets. ∗ Reset frequency: monthly, semiannual or annual.
— This implies a lower cost of borrowing. ∗ ARMs allow more families to qualify for mortgages.
— However, short-term interest rates are more volatile than long term interest rates. Therefore, borrowers are exposed to a signiﬁcant amount of risk. ∗ Typically, then, ARMs are issued with some additional contractual features, such as prespeciﬁed interest-rate caps.

The prepayment issue

• Mortgages permit the homeowners to prepay their loans.
— This introduces timing risk. If the interest rates lower, the loan portfolio will experience prepayments as borrowers will rush to reﬁnance their mortgages with less-costly loans.
— In other terms, the lender has sold an option to the homeowner. However, this option costs, which makes the borrower pay a higher interest rate on the loan.

Chapter VI - Credit-risk shifting derivatives and structured products

359

## Page 364

• There are several factors aﬀecting prepayments.

— The most important factor is the reﬁnancing incentive, which occurs when the

market rates for mortgage loans drop signiﬁcantly below the rate that borrowers are

paying.

— Seasonality factors (or school-year factors) also play a role. Things remaining equal,

families tend to move during summer time, which results in increased prepayments

during this part of the year.

— The age of the mortgage plays another important role.

∗ As we discussed earlier, during the early life of the mortgage, interest rate

payments far exceed the principal component. Hence, the incentive to prepay is

high during the earlier part of the mortgage (say in the range from 2 to 8 years).

∗ Moreover, when the mortgage is more than 25 years old (say), there may be an

incentive to prepay in order to secure the property’s title.

∗ So the speed of prepayments slows for loans in the age range 10 to 25 years.

— Family circumstances such as divorces or job switching.

— Housing prices constitute another fundamental factor aﬀecting prepayments.

∗ If the housing prices increase, then, obviously, the LTV ratio decreases, which

enhances the ability of the homeowners to reﬁnance, if the going interest rates

warrant reﬁnancing.

∗ On the other hand, if the housing prices decrease and, hence, the LTV ratio

increases, the ability of the homeowners to reﬁnance diminishes.

∗ Hence, the ability to reﬁnance and, hence, the probability of early prepayments,

should follow the housing market cycle, if the going interest rates are favorable.

Chapter VI - Credit-risk shifting derivatives and structured products

360

## Page 365

• There are diﬀerent measures of prepayment used in the industry to determine the rate of prepayment.
— The Constant Monthly Maturity measure assumes that there is a constant probability (e.g., 0.50%) that the mortgage will be prepaid following the next month’s scheduled payments. This probability is referred to as the single monthly mortality rate, or SMM.
— Usually, an annual prepayment rate known as the conditional prepayment rate (CPR) is used to measure the speed of prepayments. Given an annual CPR, one can easily estimate the CMM, and viceversa, by using the following formula,

(1 − SMM)12 = 1 − CPR

(5)

For example, SMM = 1% per month (i.e. 1% of the outstanding principal is paid down each month) implies that CPR = 1 − (1 − 001)12 = 1136%.

Chapter VI - Credit-risk shifting derivatives and structured products

361

## Page 366

— Typically, one makes assumptions about the CPR in order to obtain estimates of

the SMM.

∗ Consider, for example, the Federal Home Administration (FHA) experience.

The FHA has a large database on actual prepayments of mortgages of diﬀerent

vintages. From this dataset, one can estimate the probability that a loan will be

retired any given year.

· Let  denote the probability a new mortgage will survive to the end of any given year, where years are indexed from 1 to 30. Then, the conditional

probability that a mortgage will survive through the year , given that it has

survived

until

the

year



−

1,

is



=

 −1

.

· Then, if the conditional monthly probabilities of survival, denoted as 

( = 1 · · ·  12), are constant within each year, we have that they solve

12 = . These monthly probability are referred to as 100% FHA experience.

∗ Consider, also, the Public Securities (PSA) experience. The PSA convention

assumes that 0.2% of the principal is paid in the ﬁrst month, and will increase by

0.2% in each of the following months, up to the 30th month, ﬁnally leveling out

at 6% until the maturity. This convention is referred to as the 100% PSA. By

scaling up or down (e.g., 150% PSA), one can construct diﬀerent PSA measures.

·

Then,

the

CPR

=

6%

·

 30

(for

the

ﬁrst

30

months)

and

CPR

=

6%

(for

the

remaining months). Given this, we may compute the SMM through Eq. (5).

· Given the SMM, we use Eq. (4) and compute the scheduled prepayment by

reducing  by the SMM.

Chapter VI - Credit-risk shifting derivatives and structured products

362

## Page 367

Mortgage-backed securities (MBS)

• Agencies such as the GNMA (Government National Mortgage Association, “Ginnie Mac”), the FNMA (Federal National Mortgage Association, “Fannie Mae”) or the FHMLC (Federal Home Loan Mortgage Corporation, “Freddie Mac”) supply and stimulate credit for mortgages through its secondary market activities. For example, GNMA guarantees FHA- and VA-based mortgage-backed securities.
• The cash ﬂows (scheduled interest, principal and prepayments) from the underlying pool of mortgages (e.g., from a given geographical location) are passed through to the investors in the MBS, with the exception of fees. Payments are typically made monthly over the lifetime of the underlying loans.
• Since MBS are backed by mortgage loans and are guaranteed, credit risk is not a major factor.
— Investors pay more attention to the nature of the collateral and the structure of the issue. The main risk is prepayment risk. The investor buys a pro rata share of the cash ﬂows. If there is a drop in interest rates, prepayments will occur and pass through.
• The evaluation framework is very complex. The ﬁrst model was introduced by Dunn and McConnell (1981). The main feature of evaluation models is the occurrence of negative convexity, which arises through a mechanism similar to that mentioned for the callable bonds analyzed in Chapter III.

Chapter VI - Credit-risk shifting derivatives and structured products

363

## Page 368

Non-Agency MBS1

• For non-agency MBS, the underlying collateral does not conform to the guidelines set forth by GSEs such as Fannie Mae or Freddie Mac. Therefore, non-agency MBS do not carry the implicit or explicit guarantee of the GSEs.
• Therefore, some forms of credit enhancement are required in order for non-agency MBS to receive investment-grade ratings. Inevitably, then, multiple tranches of securities are issued, and each of them carries a diﬀerent proﬁle of risk.
• Mortgage credit risk:
— short-term delinquencies — unrecoverable losses due to borrower default
• Credit enhancement techniques, which aim to safeguard senior security holders, include:
— Internal credit enhancement, based on the reallocation of cash within the structure — External credit enhancement, based on allocation of cash by the issuer or a third
party
• Rating agencies determine the level of credit support, based on the collateral characteristics, the rating of any parties who play a signiﬁcant role in the ongoing transaction, and of course the rating desired for the security itself.

1Additional material on non-agency MBS can be found in Chapters 15 and 17 of Davidson et al. (2003).

Chapter VI - Credit-risk shifting derivatives and structured products

364

## Page 369

• Among the factors used to determine credit support are, borrower quality, loan amount, LTV ratio, loan maturity and documentation, interest-rate type, lien status.
— The lien status is the position of seniority of the loan in the case of default. There are ﬁrst liens, and second liens. (They are also called “ﬁrst mortgage” and “second mortgage”.) A second lien is a subordinated loan. First/second liens arise for example in the case of multiple mortgages, where priority is usually given to loans originated earlier.
• Subprime loans are loans made to credit-impaired, or lower-credit-quality, borrowers. In these cases, loans are matched by weak credit scores, poor veriﬁcation of income or assets, etc.
— Home equity loans (HEL)-asset backed securities today are primarily backed by subprime mortgages.
— Other instruments in the HEL market are high LTV and of course traditional prime second mortgages.
— Credit enhancement: about a half relies on third party guarantees. The other half relies on internal credit enhancement, through subordination.

Chapter VI - Credit-risk shifting derivatives and structured products

365

## Page 370

Collateralized Mortgage Obligations (CMOs)

• CMOs are a device that we may use to redistribute the cash ﬂows from a pool of mortgages or MBS. CMOs, through careful structuring (i.e. not just a pro-rata share of the cash ﬂows), can oﬀer varying levels of protection against prepayment.
— CMOs are securities based on MBS but in which there has been further splitting so as to create securities with diﬀerent maturities for example
— A typical CMO might receive interest and principal only over a certain future timeframe.
— Moreover, CMO pay semiannually or quarterly, but as we already know, now, the underlying collateral or mortgages make monthly payments. Therefore, there is some reinvestment of the cash ﬂows from the underlying collateral.
• Mortgages are ordered into tranches by some “quality” (typically, repayment time), with each tranche sold as a separate security.
— Consider, for example, the sequential CMO. A typical sequential CMO has 4 tranches. ∗ The 1st tranche receives payments (and prepayments), while the 2nd and 3rd tranches receive some ﬁxed coupons ∗ When the 1st tranche is retired, the 2nd and 3rd tranches receive the payments (and prepayments), and the 4th tranche receives no cash ﬂows until all earlier tranches are fully retired. ∗ The 4 tranches are typically called: (i) Tranche A; (ii) Tranche B; (iii) Tranche

Chapter VI - Credit-risk shifting derivatives and structured products

366

## Page 371

C; (iv) Tranche Z (which is typically bought by pension funds or insurance companies)

• CMOs tend to be rated AAA or Aaa. The key to this high reputation is the basic requirement that the cash ﬂows generated by the underlying mortgages or the agency securities are more than suﬃcient to meet the obligations of all tranches. The credit risk is minimized by having a credible third party (such as a Federal agency or a AAA insurance company) guarantee the cash ﬂows.

Chapter VI - Credit-risk shifting derivatives and structured products

367

## Page 372

Appendix: Gaussian copulae and CDO pricing

Details on the CDO pricing in Figure 1

For each name, create the following random variable,



=

√

+

 1

−



 = 1 2 3

(6)

where  is a common factor among the three names,  is an idiosynchratic term, and  ∼  (0 1),  ∼  (0 1).

Finally,  ≥ 0 is meant to capture the default correlation among the names, as follows. Assume that the risk-neutral probability each ﬁrm defaults, by  , is given by,

Q ( ) = Φ (010) ≡ 10%

where Φ is the cumulative distribution of a standard normal variable. That is, by time  , each ﬁrm defaults

any time that,

  010 ≡ Φ−1 (10%) 

Therefore,  is the default correlation among the assets in the CDO.

We can now simulate Eq. (6), build up payoﬀs for each simulation, and price the tranches by just averaging over the simulations, as explained below. Naturally, the same simulation technique can be used to price tranches on CDOs with an arbitrary number of assets.

Precisely, simulate Eq. (6), and obtain values ˜,  = 1 · · · , where  is the number of simulations and  = 1 2 3. At simulation no. , we have
˜1 ˜2 ˜3  ∈ {1 · · · } 

Chapter VI - Credit-risk shifting derivatives and structured products

368

## Page 373

We use the previously simulated values as follows:

• For each simulation , count the number of defaults across the three names, deﬁned as the number of times that ˜  010, for  = 1 2 3. Denote the number of defaults as of simulation  with Def.
• For each simulation , compute the total realized payoﬀ of the asset pool, deﬁned as,

˜ = Def · 40 + (3 − Def) · 100

• For each simulation , compute recursively the payoﬀs to each tranche, ,





 −1

 = min max ˜ −  0   

=1

where  is the nominal value of each tranche (1 = 140, 2 = 90, 3 = 70). • Estimate the price of each tranche by averaging across the simulations,

Price

Senior

=

− 1 


=1

1

Price

Mezzanine

=

− 1 


=1

2

Price

Junior

=

− 1 


=1

3

• Note, the previous calculaitons have to be performed under the risk-neutral probability . — Using the probability  in the previous algorithm can only be lead to something useful for risk-management and VaR calculations at best.

Chapter VI - Credit-risk shifting derivatives and structured products

369
