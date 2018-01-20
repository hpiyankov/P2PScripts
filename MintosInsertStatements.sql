DROP TABLE IF EXISTS DATE_VAR;
CREATE TABLE DATE_VAR (DATE TEXT);
INSERT INTO DATE_VAR VALUES ('2018-01-01');

INSERT INTO LOAN_BOOK (`Id`,`IssueDate`,`ListingDate`,`Country`,`LoanOriginator`,`LoanType`,`LoanRatePercent`,`Term`,`Collateral`,`InitialLTV`,`LTV`,`LoanStatus`,`Buybackreason`,`InitialLoanAmount`,`RemainingLoanAmount`,`Currency`,`Buyback`,`DATE`)
SELECT `Id`,`IssueDate`,`ListingDate`,`Country`,`LoanOriginator`,`LoanType`,`LoanRatePercent`,`Term`,`Collateral`,`InitialLTV`,`LTV`,`LoanStatus`,`Buybackreason`,`InitialLoanAmount`,`RemainingLoanAmount`,`Currency`,`Buyback`, (SELECT DATE FROM DATE_VAR) as `DATE`
FROM `1-500000_loan_book`;
DROP TABLE `1-500000_loan_book`;

DROP TABLE IF EXISTS DATE_SEQUENCE;
CREATE TABLE tmp_date_sequence as 
	select 
		date, 
		(select count(*) from(select distinct date from LOAN_BOOK) as LB2 where LB2.date > LB1.date)+1 as seq 
	from (select distinct date from LOAN_BOOK) as LB1;
CREATE TABLE DATE_SEQUENCE as 
	select m.date as date1, e.date as date2, e.seq as seq2
	from tmp_date_sequence e inner join tmp_date_sequence m on e.seq = m.seq-1;
DROP TABLE IF EXISTS tmp_date_sequence;

SELECT DATE, count(*) FROM LOAN_BOOK GROUP BY DATE ORDER BY 1 DESC;