DROP TABLE IF EXISTS DATE_VAR;
CREATE TABLE DATE_VAR (DATE TEXT);
INSERT INTO DATE_VAR VALUES ('2018-01-01');

INSERT INTO IUVO_PM (`Country`,`ID`,`IssueDate`,`LoanType`,`AmortizationMethod`,`LoanOriginator`,`ScoreClass`,`GuaranteedofPrincipal(%)`,`Currency`,`LoanAmount`,`RemainingPrincipal`,`InterestRate(%)`,`Term`,`PaymentsReceived`,`InstalmentType`,`Status`,`AvailableforInvestment`,`MyInvestment`,`DATE`)
SELECT `Country`,`ID`,`IssueDate`,`LoanType`,`AmortizationMethod`,`LoanOriginator`,`ScoreClass`,`GuaranteedofPrincipal(%)`,`Currency`,`LoanAmount`,`RemainingPrincipal`,`InterestRate(%)`,`Term`,`PaymentsReceived`,`InstalmentType`,`Status`,`AvailableforInvestment`,`MyInvestment`, (SELECT DATE FROM DATE_VAR) as `DATE`
FROM PM;
DROP TABLE PM;

INSERT INTO IUVO_SM (`Country`,`ID`,`IssueDate`,`LoanType`,`AmortizationMethod`,`LoanOriginator`,`ScoreClass`,`GuaranteedofPrincipal(%)`,`InterestRate(%)`,`Term`,`PaymentsReceived`,`InstalmentType`,`Status`,`XIRR(%)`,`Currency`,`AvailableforInvestment`,`Discount/Premium(%)`,`Price`,`MyInvestment`,`Date`)
SELECT `Country`,`ID`,`IssueDate`,`LoanType`,`AmortizationMethod`,`LoanOriginator`,`ScoreClass`,`GuaranteedofPrincipal(%)`,`InterestRate(%)`,`Term`,`PaymentsReceived`,`InstalmentType`,`Status`,'',`Currency`,`AvailableforInvestment`,`Discount/Premium(%)`,`Price`,`MyInvestment`, (SELECT DATE FROM DATE_VAR) as `DATE`
FROM SM;
DROP TABLE SM;

SELECT DATE, T, count FROM (
	SELECT DATE, 'PM' as T, count(*) as count FROM IUVO_PM GROUP BY DATE, T
	UNION ALL
	SELECT DATE, 'SM' as T, count(*) as count FROM IUVO_SM GROUP BY DATE, T) 
ORDER by 1 desc;

