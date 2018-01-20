create view IUVO_ALL as 
select
	IUVO.Country,
	IUVO.ID,
	IUVO.IssueDate,
	IUVO.LoanType,
	IUVO.AmortizationMethod,
	IUVO.LoanOriginator,
	IUVO.ScoreClass,
	IUVO.GarPRC,
	IUVO.Currency,
	IUVO.IR,
	MIN(IUVO.Term) as Term,
	MAX(IUVO.PaymentsReceived) as PaymentsReceived,
	IUVO.InstalmentType,
	SUM(IUVO.AvailableforInvestment) as AvailInv,
	MAX(IUVO.MyInvestment) as MyInvestment,
	IUVO.Date,
	INST.Instalment,
	MAX(STAT.Delay) as Delay
from
(	select
		Country,
		ID,
		IssueDate,
		LoanType,
		AmortizationMethod,
		LoanOriginator,
		ScoreClass,
		`GuaranteedofPrincipal(%)` as GarPRC,
		Currency,
		`InterestRate(%)` as IR,
		Term,
		PaymentsReceived,
		InstalmentType,
		Status,
		AvailableforInvestment,
		MyInvestment,
		Date
	from
	 IUVO_PM

	 union
	 select distinct
		Country,
		ID,
		IssueDate,
		LoanType,
		AmortizationMethod,
		LoanOriginator,
		ScoreClass,
		`GuaranteedofPrincipal(%)` as GarPRC,
		Currency,
		`InterestRate(%)`as IR,
		Term,
		PaymentsReceived,
		InstalmentType,
		Status,
		AvailableforInvestment,
		MyInvestment,
		Date
	 from
	 IUVO_SM) IUVO 
LEFT JOIN IUVO_INSTALMENT AS INST ON IUVO.InstalmentType = INST.InstalmentType
LEFT JOIN IUVO_STATUS AS STAT ON IUVO.Status = STAT.Status
GROUP BY
	IUVO.Country,
	IUVO.ID,
	IUVO.IssueDate,
	IUVO.LoanType,
	IUVO.AmortizationMethod,
	IUVO.LoanOriginator,
	IUVO.ScoreClass,
	IUVO.GarPRC,
	IUVO.Currency,
	IUVO.IR,
	IUVO.InstalmentType,
	IUVO.Date,
	INST.Instalment

	 

