****************************************************************************************************************
*** Table 3. Monetary poverty headcount ***
****************************************************************************************************************
** Peru **
* Round 4
gen totalexp_new=totalexp/hhsize
gen totalexp_pc_w4 = totalexp_new if round == 4 
gen extreme_pov_w4 = 0 if round == 4
	replace extreme_pov_w4 = 1 if totalexp_pc_w4 < (1.62*2.15*30)
gen moderate_pov_w4 = 0 if round == 4
	replace moderate_pov_w4 = 1 if totalexp_pc_w4 < (1.62*3.65*30)

* Round 5
gen totalexp_pc_w5 = totalexp_new if round == 5
gen extreme_pov_w5 = 0 if round == 5
	replace extreme_pov_w5 = 1 if totalexp_pc_w5 < (1.75*2.15*30)
gen moderate_pov_w5 = 0 if round == 5
	replace moderate_pov_w5 = 1 if totalexp_pc_w5 < (1.75*3.65*30)
	
****************************************************************************************************************
*** Table 4. Multidimensional poverty H, A, and M0***
****************************************************************************************************************
** Peru **
* Round 4
gen roof_w4 = 0 if round == 4
	replace roof_w4 = 1 if inlist(roof, 1, 2, 3, 5, 8, 9, 11, 12, 13, 14, 25, 20, 23, 24) & round == 4

gen floor_w4 = 0 if round == 4
	replace floor_w4 = 1 if inlist(floor, 2, 4, 10, 21) & round == 4

gen toilet_w4 = 0 if round == 4
	replace toilet_w4 = 1 if inlist(sanitation, 2, 3, 5, 7, 8, 9) & round == 4

gen drwater_w4 = 0 if round == 4
	replace drwater_w4 = 1 if inlist(drwater, 11, 12) & round == 4

gen sol_w4 = roof_w4*(1/5) + floor_w4*(1/5) + drwater_w4*(1/5)+ toilet_w4*(1/5) + cookingq*(1/5) if round == 4
gen morbidity_w4 = 0 if round == 4
	replace morbidity_w4 = 1 if chillness == 1 & round == 4
gen height_w4 = 0 if round == 4
	replace height_w4 = 1 if zhfa < -2 & round == 4
gen health_w4 = 0 if round == 4
	replace health_w4 = morbidity_w4*(1/2) + height_w4*(1/2) 
gen yrs_schooling_w4 = 0 if round == 4
	replace yrs_schooling_w4 = 1 if engrade <= 4
gen enrollment_w4 = 0 if round == 4
	replace enrollment_w4 = 1 if enrol == 0 & round == 4
gen edu_w4 = 0 if round == 4
	replace edu_w4 = yrs_schooling_w4*(1/2) + enrollment_w4*(1/2) 

** Total number of deprivations
gen n_dep_w4 = sol_w4 + health_w4 + edu_w4 

** Multidimensional headcount ratio (H) for each threshold (25%, 33%, and 50%)
* k = 25%
gen multi_pov25_w4 = 0 if round == 4
	replace multi_pov25_w4 = 1 if n_dep_w4 >= 0.75 & round == 4
* k = 33%
gen multi_pov33_w4 = 0 if round == 4
	replace multi_pov33_w4 = 1 if n_dep_w4 >= 1 & round == 4
* k = 50%
gen multi_pov50_w4 = 0 if round == 4
	replace multi_pov50_w4 = 1 if n_dep_w4 >= 1.5 & round == 4

** Average deprivation share (A) for each threshold (25%, 33%, and 50%)
* k = 25%
gen share_pov25_w4 = n_dep_w4/3 if multi_pov25_w4 == 1
	replace share_pov25_w4 = . if multi_pov25_w4 == 0 
* k = 33%
gen share_pov33_w4 = n_dep_w4/3 if multi_pov33_w4 == 1
	replace share_pov33_w4 = . if multi_pov33_w4 == 0 
* k = 50%
gen share_pov50_w4 = n_dep_w4/3 if multi_pov50_w4 == 1
	replace share_pov50_w4 = . if multi_pov50_w4 == 0 

* Adjusted headcount (M0) for each threshold (25%, 33%, and 50%) **
* k = 25%
gen M0_pov25_w4 = n_dep_w4/3 if multi_pov25_w4 == 1
	replace M0_pov25_w4 = 0 if multi_pov25_w4 == 0 
* k = 33%
gen M0_pov33_w4 = n_dep_w4/3 if multi_pov33_w4 == 1
	replace M0_pov33_w4 = 0 if multi_pov33_w4 == 0 
	
gen M0_pov50_w4 = n_dep_w4/3 if multi_pov50_w4 == 1
	replace M0_pov50_w4 = 0 if multi_pov50_w4 == 0 

* Round 5

gen roof_w5 = 0 if round == 5
	replace roof_w5 = 1 if inlist(roof, 1, 2, 3, 5, 8, 9, 11, 12, 13, 14, 25, 20, 23, 24) & round == 5

gen floor_w5 = 0 if round == 5
	replace floor_w5 = 1 if inlist(floor, 2, 4, 10, 21) & round == 5

gen toilet_w5 = 0 if round == 5
	replace toilet_w5 = 1 if inlist(sanitation, 2, 3, 5, 7, 8, 9) & round == 5
	
gen drwater_w5 = 0 if round == 5
	replace drwater_w5 = 1 if inlist(drwater, 11, 12) & round == 5

gen sol_w5 = roof_w5*(1/5) + floor_w5*(1/5) + drwater_w5*(1/5)+ toilet_w5*(1/5) + cookingq*(1/5) if round == 5
gen morbidity_w5 = 0 if round == 5
	replace morbidity_w5 = 1 if chillness == 1 & round == 5
gen height_w5 = 0 if round == 5
	replace height_w5 = 1 if zhfa < -2 & round == 5
gen health_w5 = 0 if round == 5
	replace health_w5 = morbidity_w5*(1/2) + height_w5*(1/2) 
gen yrs_schooling_w5 = 0 if round == 5
	replace yrs_schooling_w5 = 1 if engrade <= 6
gen enrollment_w5 = 0 if round == 5
	replace enrollment_w5 = 1 if enrol == 0 & round == 5
gen edu_w5 = 0 if round == 5
	replace edu_w5 = yrs_schooling_w5*(1/2) + enrollment_w5*(1/2) 

** Total number of deprivations
gen n_dep_w5 = sol_w5 + health_w5 + edu_w5 

** Multidimensional headcount ratio (H) for each threshold (25%, 33%, and 50%)
* k = 25%
gen multi_pov25_w5 = 0 if round == 5
	replace multi_pov25_w5 = 1 if n_dep_w5 >= 0.75 & round == 5
* k = 33%
gen multi_pov33_w5 = 0 if round == 5
	replace multi_pov33_w5 = 1 if n_dep_w5 >= 1 & round == 5
* k = 50%
gen multi_pov50_w5 = 0 if round == 5
	replace multi_pov50_w5 = 1 if n_dep_w5 >= 1.5 & round == 5

** Average deprivation share (A) for each threshold (25%, 33%, and 50%)
* k = 25%
gen share_pov25_w5 = n_dep_w5/3 if multi_pov25_w5 == 1
	replace share_pov25_w5 = . if multi_pov25_w5 == 0 
* k = 33%
gen share_pov33_w5 = n_dep_w5/3 if multi_pov33_w5 == 1
	replace share_pov33_w5 = . if multi_pov33_w5 == 0 
* k = 50%
gen share_pov50_w5 = n_dep_w5/3 if multi_pov50_w5 == 1
	replace share_pov50_w5 = . if multi_pov50_w5 == 0 

* Adjusted headcount (M0) for each threshold (25%, 33%, and 50%) **
* k = 25%
gen M0_pov25_w5 = n_dep_w5/3 if multi_pov25_w5 == 1
	replace M0_pov25_w5 = 0 if multi_pov25_w5 == 0 
* k = 33%
gen M0_pov33_w5 = n_dep_w5/3 if multi_pov33_w5 == 1
	replace M0_pov33_w5 = 0 if multi_pov33_w5 == 0 
	
gen M0_pov50_w5 = n_dep_w5/3 if multi_pov50_w5 == 1
	replace M0_pov50_w5 = 0 if multi_pov50_w5 == 0
	
	
	
	
	*** Table 5 Deprivation by Dimension*****

gen sol_dim_w4 = 0 if round == 4
replace sol_dim_w4 = 1 if sol_w4 >= 0.33 & round == 4
gen health_dim_w4 = 0 if round == 4
replace health_dim_w4 = 1 if health_w4 >= 0.33 & round == 4
gen edu_dim_w4 = 0 if round == 4
replace edu_dim_w4 = 1 if edu_w4 >= 0.33 & round == 4

gen sol_dim_w5 = 0 if round == 5
replace sol_dim_w5 = 1 if sol_w5 >= 0.33 & round == 5
gen health_dim_w5 = 0 if round == 5
replace health_dim_w5 = 1 if health_w5 >= 0.33 & round == 5
gen edu_dim_w5 = 5
replace edu_dim_w5 = 1 if edu_w5 >= 0.33 & round == 5

