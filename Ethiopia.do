****************************************************************************************************************
*** Table 3. Monetary poverty headcount ***
****************************************************************************************************************
** Ethiopia **
* Round 4
gen totalexp_new=totalexp/hhsize
*Generated total expenditure per capita

gen totalexp_pc_w4 = totalexp_new if round == 4 
*Generated the expenditure variable for round 4

gen extreme_pov_w4 = 0 if round == 4
	replace extreme_pov_w4 = 1 if totalexp_pc_w4 < (7.08*2.15*30)
*Created the criteria for extreme poverty for children. 
*If their expenditure per capita was less than 2.15$ per day they were impoversished 
*The 7.08 accounts for the ethiopian currency difference. The 30 accounts for the data being measured in monthly expenditures

gen moderate_pov_w4 = 0 if round == 4
	replace moderate_pov_w4 = 1 if totalexp_pc_w4 < (7.08*3.65*30)
*The criteria for moderately poor children. 
*If their expenditure per capita was less than 3.65$ per day they were impoversished 



* Round 5
gen totalexp_pc_w5 = totalexp_new if round == 5
gen extreme_pov_w5 = 0 if round == 5
	replace extreme_pov_w5 = 1 if totalexp_pc_w5 < (8.52*2.15*30)
gen moderate_pov_w5 = 0 if round == 5
	replace moderate_pov_w5 = 1 if totalexp_pc_w5 < (8.52*3.65*30)
*The same process was repeated for the wave 5 children
	
	
	
****************************************************************************************************************
*** Table 4. Multidimensional poverty H, A, and M0***
****************************************************************************************************************
** Ethiopia **
* Round 4: Generated the thresholds for poverty by indicator. Created Standard of Living, Health, and Education thresholds for dimensional poverty

gen roof_w4 = 0 if round == 4
	replace roof_w4 = 1 if inlist(roof, 1, 2, 3, 5, 8, 9, 11, 12, 13, 14, 25, 20, 23, 24) & round == 4
*Created the threshold for dimensional poverty for roofing. These values are coded for poor roofing standards. 
	
gen floor_w4 = 0 if round == 4
	replace floor_w4 = 1 if inlist(floor, 2, 4, 10, 21) & round == 4
*Created the threshold for dimensional poverty for flooring . These values are coded for poor flooring standards. 

	
gen toilet_w4 = 0 if round == 4
	replace toilet_w4 = 1 if inlist(sanitation, 2, 3, 5,7, 8, 9) & round == 4
*Created the threshold for dimensional poverty for sanitation. These values are coded for poor sanitation standards. 

	
gen drwater_w4 = 0 if round == 4
	replace drwater_w4 = 1 if inlist(drwater, 11, 12) & round == 4
*Created the threshold for dimensional poverty for unsafe drinking water. These values are coded for poor drinking water standards. 

	
gen sol_w4 = roof_w4*(1/5) + floor_w4*(1/5) + drwater_w4*(1/5)+ toilet_w4*(1/5) + cookingq_new*(1/5) if round == 4
*Generated standard of living indicator. Each housing threshold is weighted by 1/5 and summed together. 

gen morbidity_w4 = 0 if round == 4
	replace morbidity_w4 = 1 if chillness == 1 & round == 4
*Generated morbidity threshold for children who has has a serious illness before 5.
	
gen height_w4 = 0 if round == 4
	replace height_w4 = 1 if zhfa < -2 & round == 4
*Generated height threshold for stunting if their height was less than -2 standard deviations from the mean.
	
gen health_w4 = 0 if round == 4
	replace health_w4 = morbidity_w4*(1/2) + height_w4*(1/2) 
*Generated the health indicator. Each health threshold is weighted 1/2 and summed together.
	
	
gen yrs_schooling_w4 = 0 if round == 4
	replace yrs_schooling_w4 = 1 if engrade <= 2
*Generated the years of schooling threshold. They were poor educational if they were two years behind in school. Age group in 4th grade.
	
gen enrollment_w4 = 0 if round == 4
	replace enrollment_w4 = 1 if enrol == 0 & round == 4
*Generated a threshold for enrollment. Children were considered poor if they were not enrolled in school.

gen edu_w4 = 0 if round == 4
	replace edu_w4 = yrs_schooling_w4*(1/2) + enrollment_w4*(1/2) 
*Generated the education indicator. Each educational threshold was weighted 1/2 and summed together.
	
** Total number of deprivations
gen n_dep_w4 = sol_w4 + health_w4 + edu_w4 
*Calculated the total number of deprivations for each indicator 

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
*Calculated the three levels of poverty for the children.

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
*Calculated the share of children poor for each level of poverty

* Adjusted headcount (M0) for each threshold (25%, 33%, and 50%) **
* k = 25%
gen M0_pov25_w4 = n_dep_w4/3 if multi_pov25_w4 == 1
	replace M0_pov25_w4 = 0 if multi_pov25_w4 == 0 
* k = 33%
gen M0_pov33_w4 = n_dep_w4/3 if multi_pov33_w4 == 1
	replace M0_pov33_w4 = 0 if multi_pov33_w4 == 0 
* k = 50%
gen M0_pov50_w4 = n_dep_w4/3 if multi_pov50_w4 == 1
	replace M0_pov50_w4 = 0 if multi_pov50_w4 == 0 
*Calculated the adjusted headcount ratio. This code was a recommendation from my professor so I cannot speak on it much.



* Round 5: 
*The same process from round 4 was repeated for round 5 children. 
gen roof_w5 = 0 if round == 5
	replace roof_w5 = 1 if inlist(roof, 1, 2, 3, 5, 8, 9, 11, 12, 13, 14, 25, 20, 23, 24) & round == 5

gen floor_w5 = 0 if round == 5
	replace floor_w5 = 1 if inlist(floor, 2, 4, 10, 21) & round == 5

gen toilet_w5 = 0 if round == 5
	replace toilet_w5 = 1 if inlist(sanitation, 2, 3, 5, 7, 8, 9) & round == 5
	
gen drwater_w5 = 0 if round == 5
	replace drwater_w5 = 1 if inlist(drwater, 11, 12) & round == 5

gen sol_w5 = roof_w5*(1/5) + floor_w5*(1/5) + drwater_w5*(1/5)+ toilet_w5*(1/5) + cookingq_new*(1/5) if round == 5
gen morbidity_w5 = 0 if round == 5
	replace morbidity_w5 = 1 if chillness == 1 & round == 5
gen height_w5 = 0 if round == 5
	replace height_w5 = 1 if zhfa < -2 & round == 5
gen health_w5 = 0 if round == 5
	replace health_w5 = morbidity_w5*(1/2) + height_w5*(1/2) 
gen yrs_schooling_w5 = 0 if round == 5
	replace yrs_schooling_w5 = 1 if engrade <= 4
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
*Round 4: Calculated the amount children considered poor by dimension using the 33% threshold for poverty. 

gen sol_dim_w5 = 0 if round == 5
replace sol_dim_w5 = 1 if sol_w5 >= 0.33 & round == 5
gen health_dim_w5 = 0 if round == 5
replace health_dim_w5 = 1 if health_w5 >= 0.33 & round == 5
gen edu_dim_w5 = 5
replace edu_dim_w5 = 1 if edu_w5 >= 0.33 & round == 5
*Round 5: Calculated the amount children considered poor by dimension using the 33% threshold for poverty. 

