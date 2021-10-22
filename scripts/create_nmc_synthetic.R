# Load packages

library(tidyverse)  # for tidy-style coding
library(simstudy)  # for creating synthetic data
library(formatR) # for formatting code
tidy_source(width.cutoff = 50)

# Create subdirectory

#ifelse(!dir.exists("synthetic_data"), dir.create("synthetic_data"), "Folder exists already")


# Overview of variables available in NMC data

#The variables are based on the document `Information
#on our register and from revalidation_18-03-20.doc`.
#Whilst we don't know the exact way the data are
#structured, we can make a reasonable guess that the
#data are split over several spreadsheets to conform
#to a tidy one-record-per-row structure.

#The below sections outline the likely way the data
#are stored in separate spreadsheets or databases
#(with the lists of variables copied from the above
#file).
#(Note: I copied these sections directly form the
#Word document above; I manually added tabs to
#reflect the level of original indentation, then
#added asterisks to produce the required level of
#indentation in `rmarkdown`; the regex used was
#`^(\s*)(.{1,4}\.)` to find the indentation text and
#`\1* \2` to insert an asterisk and space).

## Personal data

#* 1.	Name
#* 2.	Pin number
#* 3.	Address
#  * a.	Postcode
#  * b.	County
#  * c.	Country
#* 4.	Profession
#* 5.	Field of practice (when initially joined the register)
#* 6.	Whether they have a specialist qualification (from those that we approve e.g specialist community public health nursing (SCPHN)) 
#* 7.	Date of first registration to the NMC 
#* 8.	Dates that previously left and rejoined if relevant (including how long they had left for and whether they rejoined via the Return to Practice route or standard readmission)
#  * a.	People can tell us they are leaving and also give us a reason why (Retirement; Currently not practising / opted not to practise; Ill health; Does not meet the revalidation requirements; Deceased; No Professional Indemnity Insurance. However, only around half of people who leave the register choose to tell us so – the other half either choose not to revalidate or not to pay their registration fee.
#* 9.	Country of initial training
#* a.	For those trained in the UK we know where they did their pre-registration training
#* b.	For those who trained in the UK it may be possible to extract information about date of qualification because these come through as uploads from the education provider awarding the degree.
#* 10.	Country of initial registration (i.e. England, Scotland, Wales, NI)
#* 11.	Nationality (although this is free text data so a bit of a mess)
#* 12.	Diversity information:
#  * a.	Gender
#  * b.	Age
#  * c.	Ethnicity
#  * d.	Disability
#  * e.	Religion
#  * f.	Sexual orientation
#  * g.	Gender identity
  
### Dates previously left or rejoind

#These probably need a separate table because there
#will be multiple possible entries per individual;
#these could be stored as episodes of leaving, with a
#leaving date and a rejoining date, with associated
#reasons, etc; the rejoining date can be left blank
#if appropriate or if member has not rejoined since.
#Alternatively it oculd be one-date-per-row, with a
#separate field denoting whether this was a leaving
#date or a rejoining date.
#* 8.	Dates that previously left and rejoined if relevant (including how long they had left for and whether they rejoined via the Return to Practice route or standard readmission)
#  * a.	People can tell us they are leaving and also give us a reason why (Retirement; Currently not practising / opted not to practise; Ill health; Does not meet the revalidation requirements; Deceased; No Professional Indemnity Insurance. However, only around half of people who leave the register choose to tell us so – the other half either choose not to revalidate or not to pay their registration fee.


## Fitness to practice (FtP) data

#* 13.	Any FtP concerns – for each case:
#  * a.	Source of referral (e.g. employer, member of the public etc)
#  * b.	Reason for referral
#  * c.	Allegation type
#  * d.	Employer information (although we only had this information for around 25% of the cases in the dataset we’ve used for the EDI research)


## Revalidation data

#Revalidation is required every 3 years, so we get a snapshot of the individuals comprising the nursing & midwifery workforce every three years.

#**TODO! CONFIRM FOLLOWING: The three years must be based on each indiviudal's date of first registration, so it's a snapshot of every individual every three years, rather than a 3-yearly snapshot of the workforce!**

#* 14.	At the point of revalidation (so every 3 years):
#  * a.	Are they currently practising?
#    * i.	Practising as a midwife in the UK and have submitted an intention to practise form
#    * ii.	Practising as a nurse outside the UK
#    * iii.	Practising as a midwife outside the UK
#    * iv.	Practising as a nurse in the UK
#    * v.	Geographical locator (country and geographical region e.g. London-North Central)
#  * b.	Do they wish to lapse their registration and if so why (People can tell us they are leaving and also give us a reason why (Retirement; Currently not practising / opted not to practise; Ill health; Does not meet the revalidation requirements; Deceased)
#    * i.	People can partially lapse, e.g. drop one of their registration types if they are registered as both a nurse and midwife. 
#    * ii.	For those saying they do not meet the revalidation requirement they are asked which revalidation requirement that they did not meet (Confirmation; CPD; Health and character declaration; Practice hours; Practice-related feedback; Professional indemnity arrangement declaration; Reflective discussion; Written reflective accounts)
#  * c.	People are free to declare however many jobs they like, although most people only report those up to the 450 practice hours requirement. As such, this is not a complete picture of all of the jobs that a person may have done over the three years, nor is it necessarily those jobs in which they are currently employed. For each job they have to tell us:
#    * i.	Scope of practice:
#      * 1.	Commissioning; 
#      * 2.	Direct clinical care or management – adult and general care nursing; 
#      * 3.	Direct clinical care or management – children’s and neo-natal nursing; 
#      * 4.	Direct clinical care or management – health visiting; 
#      * 5.	Direct clinical care or management – learning disabilities nursing; 
#      * 6.	Direct clinical care or management – mental health nursing; 
#      * 7.	Direct clinical care or management – midwifery; 
#      * 8.	Direct clinical care or management – occupational health; 
#      * 9.	Direct clinical care or management – public health; 
#      * 10.	Direct clinical care or management – school nursing; 
#      * 11.	Direct clinical care or management – other; 
#      * 12.	Education; 
#      * 13.	Policy; 
#      * 14.	Quality assurance or inspection; 
#      * 15.	Research; 
#      * 16.	Other
#    * ii.	Work setting: 
#      * 1.	Ambulance service; 
#      * 2.	Care home sector; 
#      * 3.	Community setting, including district nursing and community psychiatric nursing; 
#      * 4.	Consultancy; 
#      * 5.	Cosmetic or aesthetic sector; 
#      * 6.	Governing body or other leadership; 
#      * 7.	GP practice or other primary care; 
#      * 8.	Hospital or other secondary care; 
#      * 9.	Inspectorate or regulator; 
#      * 10.	Insurance or legal; 
#      * 11.	Maternity unit or birth centre; 
#      * 12.	Military; 
#      * 13.	Occupational health; 
#      * 14.	Police; 
#      * 15.	Policy organisation; 
#      * 16.	Prison; 
#      * 17.	Private domestic setting; 
#      * 18.	Public health organisation;
#      * 19.	 School; 
#      * 20.	Specialist or other tertiary care including hospice; 
#      * 21.	Telephone or e-health advice; 
#      * 22.	Trade union or professional body; 
#      * 23.	University or other research facility; 
#      * 24.	Voluntary or charity sector; 
#      * 25.	Other
#    * iii.	Employment type:
#      * 1.	Employed directly (not via UK agency); 
#      * 2.	Employed via an agency; 
#      * 3.	Self employed; 
#      * 4.	Volunteering
#    * iv.	Dates (from and to but within the last three years)
#    * v.	Is this the person’s current practice? 
#      * 1.	Yes
#      * 2.	No
#    * vi.	Postcode of employer
#    * vii.	Organisation name (free text response)
#    * viii.	Organisation address (we know that this is not always the specific site/location where people work, people often add the address of the head office for example)
#    * ix.	Country (drop down menu)
#  * d.	Whether they requested exceptional circumstances and these were awarded
#  * e.	Police charges, cautions or convictions
#  * f.	Determinations by other regulators

### Jobs since last revalidation (past three years)

#Since this can have as many entries as are needed, it should be a separate table also!

#  * c.	People are free to declare however many jobs they like, although most people only report those up to the 450 practice hours requirement. As such, this is not a complete picture of all of the jobs that a person may have done over the three years, nor is it necessarily those jobs in which they are currently employed. For each job they have to tell us:
#    * i.	Scope of practice:
#      * 1.	Commissioning; 
#      * 2.	Direct clinical care or management – adult and general care nursing; 
#      * 3.	Direct clinical care or management – children’s and neo-natal nursing; 
#      * 4.	Direct clinical care or management – health visiting; 
#      * 5.	Direct clinical care or management – learning disabilities nursing; 
#      * 6.	Direct clinical care or management – mental health nursing; 
#      * 7.	Direct clinical care or management – midwifery; 
#      * 8.	Direct clinical care or management – occupational health; 
#      * 9.	Direct clinical care or management – public health; 
#      * 10.	Direct clinical care or management – school nursing; 
#      * 11.	Direct clinical care or management – other; 
#      * 12.	Education; 
#      * 13.	Policy; 
#      * 14.	Quality assurance or inspection; 
#      * 15.	Research; 
#      * 16.	Other
#    * ii.	Work setting: 
#      * 1.	Ambulance service; 
#      * 2.	Care home sector; 
#      * 3.	Community setting, including district nursing and community psychiatric nursing; 
#      * 4.	Consultancy; 
#      * 5.	Cosmetic or aesthetic sector; 
#      * 6.	Governing body or other leadership; 
#      * 7.	GP practice or other primary care; 
#      * 8.	Hospital or other secondary care; 
#      * 9.	Inspectorate or regulator; 
#      * 10.	Insurance or legal; 
#      * 11.	Maternity unit or birth centre; 
#      * 12.	Military; 
#      * 13.	Occupational health; 
#      * 14.	Police; 
#      * 15.	Policy organisation; 
#      * 16.	Prison; 
#      * 17.	Private domestic setting; 
#      * 18.	Public health organisation;
#      * 19.	 School; 
#      * 20.	Specialist or other tertiary care including hospice; 
#      * 21.	Telephone or e-health advice; 
#      * 22.	Trade union or professional body; 
#      * 23.	University or other research facility; 
#      * 24.	Voluntary or charity sector; 
#      * 25.	Other
#    * iii.	Employment type:
#      * 1.	Employed directly (not via UK agency); 
#      * 2.	Employed via an agency; 
#      * 3.	Self employed; 
#      * 4.	Volunteering
#   * iv.	Dates (from and to but within the last three years)
#    * v.	Is this the person’s current practice? 
#      * 1.	Yes
#      * 2.	No
#    * vi.	Postcode of employer
#    * vii.	Organisation name (free text response)
#    * viii.	Organisation address (we know that this is not always the specific site/location where people work, people often add the address of the head office for example)
#    * ix.	Country (drop down menu)
  
# Defining NMC variables

#Next we define the above lists as lists of variables
#and category levels.

## How do we define categorical variables?

#One way of adding a definition of variable `xCat`
#below with three levels with proportions 0.3, 0.2
#and 0.5. The level labels are added later, when
#generating data. `simstudy` separates the
#distribution logic from the way a variable is
#instantiated.

#`def <- defData(def, varname = "xCat", formula = "0.3;0.2;0.5", dist = "categorical")`
#`def <- genFactor(def, "xCat", labels = c("one", "two", "three"))`

#For our purposes (and to be able to use the same
#definition with other packages if needed), we can
#define the variables & levels as lists of character
#vectors.

## initialise list of variables
variables <- list()



## Personal data


## this generates a set of unique pins
generate_unique_nmc_pins <- function(n) {
  # number <- runif(n = n, min=0, max = (1e6)-1)
  number <- sample(x = seq(from=0, to=(1e6)-1, by=1), size = n, replace = FALSE)
  number_6digit <- str_pad(number, width=6, pad = "0")
  letter1 <- sample(x=LETTERS,size=n,replace=TRUE)
  letter2 <- sample(x=LETTERS,size=n,replace=TRUE)
  return(
    paste0(str_sub(number_6digit, 1, 2),letter1, str_sub(number_6digit, 3, 6),letter2)
  )
}

variables$personal_data <- list(
  name = "",  # these can be generated using randomNames package
  pin_number = "",  # this is in format of 00X0000X where 0 is a digit and X is a letter
  address_postcode = c("testpostcode1","testpostcode2"),  # TODO; find a list of all possible postcodes
  address_county = c("Nonexistentshire","Nonexistentland","N-on-existent"),  # TODO: find a list of all possible counties
  address_country = c("Scotland","England","Wales","Northern Ireland"),  # TODO: Isle of Man, other jurisdictions? do they count
  profession = c("Nurse","Midwife", "Nurse & Midwife"),  # TODO: is this Nrusing/Midwifery or more specific?
  field_of_practice_when_joined_register = c("Adult","Mental health"),  # TODO: adult/MH/LD?
  have_specialist_qualification_approved_by_nmc = c(TRUE, FALSE),
  specialist_qualification = c(
    "RN1: Adult nurse, level 1",
    "RNA: Adult nurse, level 1",
    "RN3: Mental health nurse, level 1",
    "RNMH: Mental health nurse, level 1",
    "RN5: Learning disabilities nurse, level 1",
    "RNLD: Learning disabilities nurse, level 1",
    "RN8: Children's nurse, level 1",
    "RNC: Children's nurse, level 1",
    "RN2: Adult nurse, level 2",
    "RN4: Mental health nurse, level 2",
    "RN6: Learning disabilities nurse, level 2",
    "RN7: General nurse, level 2",
    "RN9: Fever nurse, level 2",
    "RM: Midwife",
    "NAR: Nursing associate",
    "RHV: Health visitor",
    "HV: Health visitor",
    "RSN: School nurse",
    "SN: School nurse",
    "ROH: Occupational health nurse",
    "OH: Occupational health nurse",
    "RFHN: Family health nurse",
    "FHN: Family health nurse",
    "RPHN: Specialist community public health nurse",
    "V100: Community practitioner nurse prescriber",
    "V150: Community practitioner nurse prescriber (without SPQ or SCPHN)",
    "V200: Nurse independent prescriber (extended formulary)",
    "V300: Nurse independent / supplementary prescriber",
    "LPE: Lecturer / Practice educator",
    "TCH: Teacher",
    "SPA: Specialist practitioner: Adult nursing",
    "SPMH: Specialist practitioner: Mental health",
    "SPC: Specialist practitioner: Children's nursing",
    "SPLD: Specialist practitioner: Learning disability nurse",
    "SPGP: Specialist practitioner: General practice nursing",
    "SCMH: Specialist practitioner: Community mental health nursing",
    "SCLD: Specialist practitioner: Community learning disabilities nursing",
    "SPCC: Specialist practitioner: Community children’s nursing",
    "SPDN: Specialist practitioner: District nursing"
    ),
  date_registration_to_nmc = c("testdate1","testdate2"),  # date variable
  # dates_previously_left_and_rejoined,   # this goes in a separate table b/c there are multiple entries possible
  country_of_initial_training = c("Scotland","England","Wales","Northern Ireland","Outside UK"),
  country_of_initial_training_outside_uk = "",
  place_of_pre_registration_training = "",  # For those trained in the UK we know where they did their pre-registration training
  date_of_qualification = c("testdate1","testdate2"),  # date variable; For those who trained in the UK it may be possible to extract information about date of qualification because these come through as uploads from the education provider awarding the degree.
  country_of_initial_registration = c("Scotland","England","Wales","Northern Ireland"),  # TODO: Isle of Man, other jurisdictions? do they count
  nationality = c("British","Other"),  # TODO: find nationalities list (although this is free text data so a bit of a mess)
  diversity_gender = c("Female","Male","Other"),  # TODO: is this sex?
  diversity_ethnicity = c("White - British", "White - Irish", "White - Gypsy or Irish Traveller", "White - Other White", "Mixed/Multiple ethnic group - White and Black Caribbean", "Mixed/Multiple ethnic group - White and Black African", "Mixed/Multiple ethnic group - White and Asian", "Mixed/Multiple ethnic group - Other Mixed", "Asian/Asian British - Indian", "Asian/Asian British - Pakistani", "Asian/Asian British - Bangladeshi", "Asian/Asian British - Chinese", "Asian/Asian British - Other Asian", "Black/African/Caribbean/Black British - African", "Black/African/Caribbean/Black British - Caribbean", "Black/African/Caribbean/Black British - Other Black", "Other ethnic group - Arab", "Other ethnic group - Any other ethnic group"),  # copy-pasted from a census 2011 report
  # diversity_disability = c("Yes", "No"),  # TODO: add once we know the categories!
  diversity_religion = c("No religion", "Christian", "Buddhist", "Hindu", "Jewish", "Muslim", "Sikh", "Other religion", "Religion not stated")#,  # copy-pasted from a census 2011 report 
  # diversity_sexual_orientation = "",  # TODO: add once we know the categories!
  # diversity_gender_identity = ""  # TODO: add once we know the categories!
)


### Leaving and rejoining dates & reasons

variables$leaving_and_rejoining <- list(
  date_of_leaving = "",
  date_of_rejoining = "",
  reason_for_leaving = c("Retirement", "Currently not practising / opted not to practise", "Ill health", "Does not meet the revalidation requirements", "Deceased", "No Professional Indemnity Insurance")  # However, only around half of people who leave the register choose to tell us so – the other half either choose not to revalidate or not to pay their registration fee.
)


## Fitness to practice


variables$fitness_to_practice <- list(  # TODO: complete this from structured data held by NMC
  source_of_referral = c("Employer","Member fo the public"),  # (e.g. employer, member of the public etc)
  reason_for_referral = c("Reason1","Reason2"),
  allegation_type = c("allegationtype1","allegationtype2"),
  employer_information = c("Information from employer","") # (although we only had this information for around 25% of the cases in the dataset we’ve used for the EDI research)
)

## Revalidation

variables$revalidation <- list(
  are_they_currently_practising = c(TRUE, FALSE),
  curently_practising = c(
    "Midwife in UK & have submitted intention to practise form",
    "Nurse outside the UK",
    "Midwife outside the UK",
    "Nurse inside the UK"
    ),
  currently_practising_geographical_locator = "",  # TODO: (country and geographical region e.g. London-North Central)
  wish_to_lapse_registration = c("Yes", "No", "Partial lapse"),
  wish_to_lapse_reason = c("Retirement", "Currently not practising / opted not to practise", "Ill health", "Does not meet the revalidation requirements", "Deceased"),
  wish_to_partially_lapse_which_part = c("Nurse", "Midwife"),
  which_revalidation_requirement_not_met = c("Confirmation", "CPD", "Health and character declaration", "Practice hours", "Practice-related feedback", "Professional indemnity arrangement declaration", "Reflective discussion", "Written reflective accounts"),
  exceptional_circumstances_requested = c(TRUE,FALSE),
  exceptional_circumstances_awarded = c(TRUE,FALSE),
  police_charges_cautions_or_convictions = "",
  determinations_by_other_regulators = ""
)

### Jobs since last revalidation (past three years)

variables$jobs_since_last_revalidation <- list(
  scope_of_practice = c(
    "Commissioning",
    "Direct clinical care or management – adult and general care nursing",
    "Direct clinical care or management – children’s and neo-natal nursing",
    "Direct clinical care or management – health visiting",
    "Direct clinical care or management – learning disabilities nursing",
    "Direct clinical care or management – mental health nursing",
    "Direct clinical care or management – midwifery",
    "Direct clinical care or management – occupational health",
    "Direct clinical care or management – public health",
    "Direct clinical care or management – school nursing",
    "Direct clinical care or management – other",
    "Education",
    "Policy",
    "Quality assurance or inspection",
    "Research",
    "Other"
  ),
  work_setting = c(
    "Ambulance service",
    "Care home sector",
    "Community setting, including district nursing and community psychiatric nursing",
    "Consultancy",
    "Cosmetic or aesthetic sector",
    "Governing body or other leadership",
    "GP practice or other primary care",
    "Hospital or other secondary care",
    "Inspectorate or regulator",
    "Insurance or legal",
    "Maternity unit or birth centre",
    "Military",
    "Occupational health",
    "Police",
    "Policy organisation",
    "Prison",
    "Private domestic setting",
    "Public health organisation",
    "School",
    "Specialist or other tertiary care including hospice",
    "Telephone or e-health advice",
    "Trade union or professional body",
    "University or other research facility",
    "Voluntary or charity sector",
    "Other"
  ),
  employment_type = c(
    "Employed directly (not via UK agency)",
    "Employed via an agency",
    "Self employed",
    "Volunteering"
  ),
  date_start = "",
  date_end = "",
  is_this_their_current_practice = c(TRUE, FALSE),
  employer_postcode = c("testpostcode1","testpostcode2"),
  organisation_name = c("Test organisation 1","Test organisation 2"),
  organisation_address = "",  # Organisation address (we know that this is not always the specific site/location where people work, people often add the address of the head office for example)
  organisation_country = c("Scotland","England","Wales","Northern Ireland", "Outside UK")  # maybe any country more appropriate?
)

# Creating dataset with `simstudy`

## Assign probabilities to the variables

# TODO: replace these with actual values!
# TODO: for now, we'll just make it uniform probability for every option

return_equal_probabilities_for_items <- function(some_items) {
  n <- length(some_items)
  rep(x = 1/n, times = n)
}

probabilities_tbl <- list()

probabilities_tbl$personal_data <- tribble(
  ~variable, ~labels, ~odds,
  "profession", c("Nurse","Midwife"), c(0.93, 0.7)
)

# a bit convoluted, but for every dataset in variables, go through the variables within the dataset, and run return_equal_probabilities_for_items
probabilities <-
  map(
    .x = variables,
    .f = function(datasets) {
      map(
        .x = datasets,
        .f = function(vars_in_dataset) {
          return_equal_probabilities_for_items(vars_in_dataset)
        }
      )
    }
  )

# keep only probabilities that have more than one option defined
probabilities_for_rough_test <-
  map(
    .x = probabilities,
    .f = function(datasets) {
        datasets[map_lgl(datasets, ~length(.x)!=1)]
    }
  )

# Generating data

## Define number of records to generate

#We need to define how many data points we want. We
#start with a value `n`, from which we'll then define
#the sizes of the other datasets - past jobs, fitness
#to practice, revalidations, etc.


# n <- 1e5L  # too big
n <- 5e3L
n_leaving_and_rejoining <- as.integer(0.3 * n)  # 30 % of nurses have breaks in career?
n_fitness_to_practice <- as.integer(0.01 * n)  # assuming 1% of nurses have fitness to practice entries
n_revalidation <- as.integer(n * 4)  # assuming 4 revalidation entries per nurse on average
n_jobs_since_last_revalidation <- as.integer(1.5 * n)  # assuming 1.5 jbs per nurse on average

# TODO: make spines for linking synthesised datasets
#to individuals!

## Enter probabilities into `simstudy`

create_synthetic_data_from_list <- function(list_of_probabilities) {
  reduce(
    .x = names(list_of_probabilities)[-1],  # the first value is instead passed as .init below
    .f = function(x, y) {  # note, x is a simstudy definition, and y is a name within the probabilities list
      # x carries over from the previous step, and we use the name y to define a new variable:
      probabilities_formatted <- paste0(list_of_probabilities[[y]], collapse="; ")
      defData(dtDefs = x, varname = y, formula = probabilities_formatted, dist = "categorical")
    },
    .init = defData(varname = names(list_of_probabilities)[1], formula = paste0(list_of_probabilities[[1]], collapse = "; "), dist = "categorical")
  )
}

synthetic_definitions <- map(
  .x = names(probabilities_for_rough_test),
  .f = ~create_synthetic_data_from_list(probabilities_for_rough_test[[.x]])
) %>% set_names(names(probabilities_for_rough_test))

synthetic <- list()

generate_data_from_definition_and_populate_categories <- function(data_definition) {  # TODO: replace variable naming! data_definition is the name of the dataset actually
  synthetic_data <- genData(n = n, dtDefs = synthetic_definitions[[data_definition]])
  names(synthetic_data) %>%
    set_names %>%
    map_dfc(
      .x = .,
      .f = ~(variables[[data_definition]][[.x]][synthetic_data[[.x]]])
      )
}

synthetic <- map(  # this step takes the longest
  .x = names(synthetic_definitions),
  .f = ~generate_data_from_definition_and_populate_categories(.x)
) %>% set_names(names(synthetic_definitions))


## Assigning ids to records

#To make the dataset have some semblance of realism,
#we need to define out who the records belong to.
#E.g. every nurse on record needs to have a
#revaliadtion records, but can have more than one -
#same for past jobs. Not all nurses will have fitness
#to practice records, however.


ids <- tibble(
  pin = generate_unique_nmc_pins(n=n)
)

ids_leaving_and_rejoining <- tibble(
  pin = sample(x = ids$pin, size = n_fitness_to_practice, replace = FALSE)
)
  
stopifnot(n_distinct(ids$pin)==length(ids$pin))  # test that all pins are unique

tibble(
  records = rpois(n, lambda=0.5) + 1
) %>% mutate(
  records = if_else(records > 4, 4, records),
  total = sum(records)
) %>% count(records, total)

ids_fitness_to_practice <-
  tibble(
    pin = sample(x = ids$pin, size = n_fitness_to_practice, replace = TRUE)
  )

# synthetic$personal_data <-
#   bind_cols(
#     ids %>% mutate(name=randomNames::)
#   )


# Pseudocode example

# personal_data %>%
#   left_join(revalidation, by = "PIN") %>%
#   group_by(PIN) %>%
#   slice_max(date_revalidation) %>%
#   filter(wish_to_lapse_registration == "Yes") %>%
#   group_by(specialty, gender) %>%
#   count()

# Save generated data as `.csv`

#if (!dir.exists("./data/processed")) dir.create("./data/processed")  # create output directory

walk(
  .x = names(synthetic),
  .f = ~write_csv(x = synthetic[[.x]], path = paste0("./data/processed/", "synthetic_", .x, ".csv"))
)

# read in data 

synthftp <- read.csv("./data/processed/synthetic_fitness_to_practice.csv")
synthpd <- read.csv("./data/processed/synthetic_personal_data.csv")
synthr <- read.csv("./data/processed/synthetic_revalidation.csv")
synthjr <- read.csv("./data/processed/synthetic_jobs_since_last_revalidation.csv")
synthlr <- read.csv("./data/processed/synthetic_leaving_and_rejoining.csv")
