*/The mental health of children in contact with social services: 
a population-wide record-linkage study in Northern Ireland*/

*For a description of variables see Supplementary Table S1

*******************************************
**STATA code for descriptive statistics
*******************************************

**Exposure**
************
*varname NEW_k2ss_history
*exposure subgroups coded:
*1 no involvement
*2 Not in Need (NIN) before 2015
*3 Child in Need (CIN) before 2015
*4 Child in Care (CIC) before 2015
*5 NIN in 2015
*6 CIN in 2015
*7 CIC in 2015

*crosstab
tab NEW_k2ss_history, m

**Covariates**
**************

**Child age at 1st January 2015 - continuous
*varname agejan15
**mean age
bysort NEW_k2ss_history: tabstat agejan15, stats (mean sd)

**child age categorical
*varname agejan15cat
*1 age 0-10 years
*2 11-17 years 
**crosstab exposure and age 
tab NEW_k2ss_history agejan15cat, m row chi

**Gender
*varname gender2
*1 Female
*2 Male
*crosstab exposure and gender 
tab NEW_k2ss_history gender2, m row chi

**Area-level income deprivation
*varname income_deprivation2
*1 more deprived
*2 less deprived
*crosstab exposure and deprivation 
tab NEW_k2ss_history income_deprivation2, m row chi

**Level of conurbation
*varname settlement_band2
*1 intermediate
*2 rural 
*3 urban
*crosstab exposure and conurbation
tab NEW_k2ss_history settlement_band2, m row chi

***Social care characteristics**

*Child age first referral to social services - continuous
*varname age_first_k2ss
*mean age 
bysort NEW_k2ss_history: tabstat age_first_k2ss, stats (mean sd)

*child age at first referral to social services - categorical
*varname age_first_k2ss_grp
*1 0-3 years
*2 4-10 years
*3 11+ years 
*crosstab exposure and age first referred 
tab NEW_k2ss_history age_first_k2ss_grp, m row chi

**age first in care for CIC only 
*varname continuous variable, age_first_LAC
bysort NEW_k2ss_history: tabstat age_first_LAC, stats (mean sd)
*varname categorical variable age_first_LAC_grp
*1 0-3 years
*2 4-10 years
*3 11+ years
*crosstab exposure and age first in care 
tab NEW_k2ss_history age_first_LAC_grp, m row chi

*Most common reason referred to social services 
*varname combined_common_reason_CIN_3
*1 parent/guardian factors
*2 wellbeing prejudiced
*3 other
*4 Not in Need
*crosstab exposure and reason
tab NEW_k2ss_history combined_common_reason_CIN_3, m row chi

*Most frequent reason placed in care
*varname reason_LAC
*1 parent/guardian factors
*2 abuse/neglect
*3 other
*crosstab exposure and reason in care
*varname for in care in 2015 is care_2015 
tab care_2015 reason_LAC if LAC==1, m row chi 

**Number of referral episodes to social services
**varname continuous variable num_rows_CIN
bysort NEW_k2ss_history: tabstat num_rows_CIN, stats (mean sd)
*varname categorical variable num_rows_CIN_cats
*1 1 episode 
*2 2-3 episodes
*3 4 or more episodes
*crosstab exposure and number referrals 
tab NEW_k2ss_history num_rows_CIN_cats, m row chi

**Number of care episodes
*for CIC only
*varname count_episodes_cats
*1 1 episode 
*2 2-3 episodes
*3 4 or more episodes
*crosstab exposure and number of care episodes
tab care_2015 count_episodes_cats if LAC==1, m row chi  

**Care placement type
**for CIC only
*varname most_common_care_type3
*1 foster care
*2 kinship care
*3 children's home
*4 other
*crosstab exposure and placement type 
tab care_2015 most_common_care_type3 if LAC==1, m row chi 


**Mental health outcomes**
***************************

**Antidepressants
*y/n one at least 1 prescription/item in 2015
*varname AD_2015
*crosstab with exposure 
tab NEW_k2ss_history AD_2015, m row chi

**Anxiolytics
*y/n one at least 1 prescription/item in 2015
*varname ANX_2015
*crosstab with exposure
tab NEW_k2ss_history ANX_2015, m row chi

**Antipsychotics
*y/n one at least 1 prescription/item in 2015
*varname AP_2015
*crosstab with exposure
tab NEW_k2ss_history AP_2015, m row chi

***Hypnotics
*y/n one at least 1 prescription/item in 2015
*varname HYP_2015
*crosstab with exposure
tab NEW_k2ss_history HYP_2015, m row chi

**Self-harm or self-harm/suicidal ideation
*y/n presented to ED with self-harm/ideation in 2015
*varname SH_2015
*crosstab with exposure
tab NEW_k2ss_history SH_2015, m row chi

**Psychiatric hospital admission
**numbers too small to look by care exposure
*included in any mental health outcome any_mh_2015

**Any psychotropic meds
*y/n one at least 1 prescription/item in 2015 for the 4 meds categories
*varname any_psychmeds_2015
*crosstab with exposure
tab NEW_k2ss_history any_psychmeds_2015, m row chi

**Any MH outcome 2015
*y/n one at least 1 prescription/item, self-harm/ideation, psych admission 
*varname any_mh_2015
tab NEW_k2ss_history any_mh_2015, m row chi 

**********************************************************
*Multilevel logistic regressions for each outcome
*children known to social services vs those never known
**********************************************************

*Antidepressants
**stepwise models adjusting for 5 Health and Social Care Trusts
*cluster variable varname GP_Trust
melogit AD_2015 i.NEW_k2ss_history || GP_Trust:, or 
estat icc
melogit AD_2015 i.NEW_k2ss_history agejan15 ib2.gender2 || GP_Trust:, or 
estat icc
melogit AD_2015 i.NEW_k2ss_history agejan15 ib2.gender2 ib2.income_deprivation2 ib2.settlement_band2 || GP_Trust:, or 
estat icc

*Anxiolytics
**stepwise models adjusting for 5 Health and Social Care Trusts
melogit ANX_2015 i.NEW_k2ss_history || GP_Trust:, or 
estat icc
melogit ANX_2015 i.NEW_k2ss_history agejan15 ib2.gender2 || GP_Trust:, or 
estat icc
melogit ANX_2015 i.NEW_k2ss_history agejan15 ib2.gender2 ib2.income_deprivation2 ib2.settlement_band2 || GP_Trust:, or 
estat icc

*Antipsychotics
**stepwise models adjusting for 5 Health and Social Care Trusts
melogit AP_2015 i.NEW_k2ss_history || GP_Trust:, or 
estat icc
melogit AP_2015 i.NEW_k2ss_history agejan15 ib2.gender2 || GP_Trust:, or 
estat icc
melogit AP_2015 i.NEW_k2ss_history agejan15 ib2.gender2 ib2.income_deprivation2 ib2.settlement_band2 || GP_Trust:, or 
estat icc

*Hypnotics
**stepwise models adjusting for 5 Health and Social Care Trusts
melogit HYP_2015 i.NEW_k2ss_history || GP_Trust:, or 
estat icc
melogit HYP_2015 i.NEW_k2ss_history agejan15 ib2.gender2 || GP_Trust:, or 
estat icc
melogit HYP_2015 i.NEW_k2ss_history agejan15 ib2.gender2 ib2.income_deprivation2 ib2.settlement_band2 || GP_Trust:, or 
estat icc

*Any psych meds
**stepwise models adjusting for 5 Health and Social Care Trusts
melogit any_psychmeds_2015 i.NEW_k2ss_history || GP_Trust:, or 
estat icc
melogit any_psychmeds_2015 i.NEW_k2ss_history agejan15 ib2.gender2 || GP_Trust:, or 
estat icc
melogit any_psychmeds_2015 i.NEW_k2ss_history agejan15 ib2.gender2 ib2.income_deprivation2 ib2.settlement_band2 || GP_Trust:, or 
estat icc

*Self-harm or self-harm/ideation
**stepwise models adjusting for 5 Health and Social Care Trusts
melogit SH_2015 i.NEW_k2ss_history || GP_Trust:, or 
estat icc
melogit SH_2015 i.NEW_k2ss_history agejan15 ib2.gender2 || GP_Trust:, or 
estat icc
melogit SH_2015 i.NEW_k2ss_history agejan15 ib2.gender2 ib2.income_deprivation2 ib2.settlement_band2 || GP_Trust:, or 
estat icc

*Any mental health outcome
**stepwise models adjusting for 5 Health and Social Care Trusts
melogit any_mh_2015 i.NEW_k2ss_history || GP_Trust:, or 
estat icc
melogit any_mh_2015 i.NEW_k2ss_history agejan15 ib2.gender2 || GP_Trust:, or 
estat icc
melogit any_mh_2015 i.NEW_k2ss_history agejan15 ib2.gender2 ib2.income_deprivation2 ib2.settlement_band2 || GP_Trust:, or 
estat icc

*Sensitivity analyses 3 or more prescription/item
*Use code above with outcome defined as 3 or more prescriptions/items

************************************************************
**Multilevel regression models for within CIN in 2015 only
************************************************************

*exposure variable varname CIN_LAC_2015
*1=CIN in 2015

**Any psych meds 2105 adjusting for clustering 5 Health and Social Care Trusts
*univariate models
*reason referred
melogit any_psychmeds_2015 ib3.combined_common_reason_CIN_3 if CIN_LAC_2015==1 || GP_Trust:, or
*age first referred
melogit any_psychmeds_2015 i.age_first_k2ss_grp if CIN_LAC_2015==1 || GP_Trust:, or
*number referral episodes
melogit any_psychmeds_2015 i.num_rows_CIN_cats if CIN_LAC_2015==1 || GP_Trust:, or

**Fully adjusted model with all covariates
melogit any_psychmeds_2015 ib2.gender2 agejan15 ib2.income_deprivation2 ib2.settlement_band2 ib3.combined_common_reason_CIN_3 ///
i.age_first_k2ss_grp i.num_rows_CIN_cats if CIN_LAC_2015==1 || GP_Trust:, or 
estat icc

*For any mh outcome, change outcome varname to any_mh_2015


************************************************************
**Multilevel regression models for within CIC in 2015 only
************************************************************

*exposure variable varname CIN_LAC_2015
*2=CIC in 2015 (in care)

**Any psych meds 2105 adjusting for clustering 5 Health and Social Care Trusts
*univariate models
*reason in care
melogit any_psychmeds_2015 ib3.reason_LAC if CIN_LAC_2015==2 || GP_Trust:, or
*age first in care_2015
melogit any_psychmeds_2015 i.age_first_LAC_grp if CIN_LAC_2015==2 || GP_Trust:, or 
*number of care episodes
melogit any_psychmeds_2015 i.count_episodes_cats if CIN_LAC_2015==2 || GP_Trust:, or 
*placement type
melogit any_psychmeds_2015 i.most_common_care_type3 if CIN_LAC_2015==2 || GP_Trust:, or 

**Fully adjusted model with all covariates
melogit any_psychmeds_2015 agejan15 ib2.gender2 ib2.income_deprivation2 ib2.settlement_band2 ///
ib3.reason_LAC i.age_first_LAC_grp i.count_episodes_cats i.most_common_care_type3 if CIN_LAC_2015==2 || GP_Trust:, or 
estat icc

*for any mh outcome change varname to any_mh_2015

*The end*
