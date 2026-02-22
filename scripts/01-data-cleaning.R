# =============================================================================
# Internship Application Analytics — Data Cleaning Script
# =============================================================================
# Author: Sahima Gupta (gupta.sahima@gmail.com)
# Date: February 2026
# Description: Cleans and processes internship application data from the
#   Ministry of Women and Child Development (WCD) internship programme.
#   478 female applicants across 28 Indian states.
# =============================================================================

# Load required packages
library(tidyverse)
library(readr)
library(lubridate)
library(janitor)

cat("=== Internship Application Data Cleaning ===\n\n")

# =============================================================================
# STEP 1: Load raw data
# =============================================================================

raw_data <- read_csv("data/raw/internship_applications.csv", show_col_types = FALSE)
cat("Raw data loaded:", nrow(raw_data), "rows x", ncol(raw_data), "columns\n")

# =============================================================================
# STEP 2: Select and rename relevant columns
# =============================================================================

# Keep only the analytical columns (drop file upload URLs, contact details)
clean_data <- raw_data %>%
  select(
    serial_no = `S.No`,
    name = Name,
    age = Age,
    dob = `Date of Birth`,
    is_rural = `Rural/Non-Rural`,
    state = State,
    zone = Zone,
    applicant_category = Category,
    institution = `Name of University/College/Institution/Organisation currently enrolled/associated with`,
    course = `Name of the course in which enrolled in above institution currently(For students/scholars)`,
    course_duration = `Course Duration (Year and Month of completion) (For students/scholars)`,
    degree_type = `Degree Type`,
    subject = `Subject...17`,
    qualification = Qualification,
    passing_year = Year,
    university = University,
    aggregate_percentage = `Aggregate Percentage`,
    hostel_required = `Hostel Required`
  )

cat("Selected", ncol(clean_data), "relevant columns\n")

# =============================================================================
# STEP 3: Clean individual columns
# =============================================================================

clean_data <- clean_data %>%
  mutate(
    # Standardize state names (title case)
    state = str_to_title(state),

    # Fix common state name variations
    state = case_when(
      state == "Jammu & Kashmir" ~ "Jammu & Kashmir",
      state == "Delhi" ~ "Delhi",
      state == "Orissa" ~ "Odisha",
      TRUE ~ state
    ),

    # Clean rural indicator: "Yes" means rural, "No" means urban
    area_type = case_when(
      is_rural == "Yes" ~ "Rural",
      is_rural == "No" ~ "Urban",
      TRUE ~ NA_character_
    ),

    # Clean applicant category
    applicant_category = case_when(
      is.na(applicant_category) ~ "Not Specified",
      TRUE ~ str_to_title(applicant_category)
    ),

    # Clean degree type
    degree_type = case_when(
      is.na(degree_type) ~ "Not Specified",
      degree_type == "PGDM" ~ "Post Graduate Diploma",
      TRUE ~ str_to_title(degree_type)
    ),

    # Create age groups for analysis
    age_group = case_when(
      age <= 21 ~ "18-21",
      age <= 24 ~ "22-24",
      age <= 27 ~ "25-27",
      age <= 30 ~ "28-30",
      age > 30 ~ "30+",
      TRUE ~ NA_character_
    ),

    # Clean percentage — convert to numeric, handle CGPA vs percentage
    percentage_clean = as.numeric(str_extract(as.character(aggregate_percentage), "[\\d.]+")),
    # If value is <= 10, it's likely CGPA — convert to approximate percentage
    percentage_clean = if_else(
      percentage_clean <= 10 & !is.na(percentage_clean),
      percentage_clean * 10,  # Rough CGPA to percentage conversion
      percentage_clean
    ),

    # Create performance categories
    performance_band = case_when(
      percentage_clean >= 80 ~ "Distinction (80%+)",
      percentage_clean >= 60 ~ "First Class (60-79%)",
      percentage_clean >= 50 ~ "Second Class (50-59%)",
      percentage_clean >= 40 ~ "Pass (40-49%)",
      percentage_clean < 40 ~ "Below Average (<40%)",
      TRUE ~ "Not Available"
    ),

    # Clean hostel requirement
    hostel_required = if_else(hostel_required == "Yes", "Yes", "No"),

    # Clean qualification names for consistency
    qualification_clean = case_when(
      is.na(qualification) ~ "Not Specified",
      str_detect(str_to_lower(qualification), "b\\.?a|bachelor of arts") ~ "B.A.",
      str_detect(str_to_lower(qualification), "b\\.?sc|bachelor of science") ~ "B.Sc.",
      str_detect(str_to_lower(qualification), "b\\.?com|bachelor of commerce") ~ "B.Com.",
      str_detect(str_to_lower(qualification), "b\\.?tech|b\\.?e\\b") ~ "B.Tech/B.E.",
      str_detect(str_to_lower(qualification), "m\\.?a|master of arts") ~ "M.A.",
      str_detect(str_to_lower(qualification), "m\\.?sc|master of science") ~ "M.Sc.",
      str_detect(str_to_lower(qualification), "m\\.?com") ~ "M.Com.",
      str_detect(str_to_lower(qualification), "m\\.?tech") ~ "M.Tech.",
      str_detect(str_to_lower(qualification), "ll\\.?b|law") ~ "LLB/Law",
      str_detect(str_to_lower(qualification), "mba|m\\.?b\\.?a") ~ "MBA",
      str_detect(str_to_lower(qualification), "ph\\.?d|doctor") ~ "Ph.D.",
      str_detect(str_to_lower(qualification), "b\\.?ed|education") ~ "B.Ed.",
      str_detect(str_to_lower(qualification), "bca|mca") ~ "BCA/MCA",
      str_detect(str_to_lower(qualification), "12|intermediate|higher secondary") ~ "12th/Intermediate",
      TRUE ~ str_to_title(qualification)
    ),

    # Clean passing year
    passing_year_clean = as.integer(str_extract(as.character(passing_year), "\\d{4}")),

    # Graduation status based on passing year
    graduation_status = case_when(
      is.na(passing_year_clean) ~ "Unknown",
      passing_year_clean <= 2025 ~ "Completed",
      passing_year_clean > 2025 ~ "Pursuing",
      TRUE ~ "Unknown"
    )
  )

cat("Columns cleaned and transformed\n")

# =============================================================================
# STEP 4: Create summary datasets for the dashboard
# =============================================================================

# --- State-level summary ---
state_summary <- clean_data %>%
  group_by(state, zone) %>%
  summarise(
    total_applicants = n(),
    avg_age = round(mean(age, na.rm = TRUE), 1),
    rural_count = sum(area_type == "Rural", na.rm = TRUE),
    urban_count = sum(area_type == "Urban", na.rm = TRUE),
    rural_pct = round(rural_count / total_applicants * 100, 1),
    hostel_needed_pct = round(sum(hostel_required == "Yes") / total_applicants * 100, 1),
    avg_percentage = round(mean(percentage_clean, na.rm = TRUE), 1),
    graduate_count = sum(degree_type == "Graduate", na.rm = TRUE),
    postgrad_count = sum(degree_type == "Post Graduate", na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(total_applicants))

cat("State summary created:", nrow(state_summary), "states\n")

# --- Zone-level summary ---
zone_summary <- clean_data %>%
  group_by(zone) %>%
  summarise(
    total_applicants = n(),
    avg_age = round(mean(age, na.rm = TRUE), 1),
    rural_pct = round(sum(area_type == "Rural", na.rm = TRUE) / n() * 100, 1),
    hostel_needed_pct = round(sum(hostel_required == "Yes") / n() * 100, 1),
    avg_percentage = round(mean(percentage_clean, na.rm = TRUE), 1),
    students_pct = round(sum(applicant_category == "Student") / n() * 100, 1),
    .groups = "drop"
  ) %>%
  arrange(desc(total_applicants))

cat("Zone summary created:", nrow(zone_summary), "zones\n")

# --- Qualification distribution ---
qualification_dist <- clean_data %>%
  count(qualification_clean, sort = TRUE) %>%
  mutate(percentage = round(n / sum(n) * 100, 1))

cat("Qualification distribution created:", nrow(qualification_dist), "categories\n")

# =============================================================================
# STEP 5: Save cleaned datasets
# =============================================================================

write_csv(clean_data, "data/cleaned/applications_clean.csv")
write_csv(state_summary, "data/cleaned/state_summary.csv")
write_csv(zone_summary, "data/cleaned/zone_summary.csv")
write_csv(qualification_dist, "data/cleaned/qualification_distribution.csv")

cat("\n=== Data Cleaning Complete ===\n")
cat("Files saved:\n")
cat("  1. data/cleaned/applications_clean.csv (", nrow(clean_data), "rows)\n")
cat("  2. data/cleaned/state_summary.csv (", nrow(state_summary), "states)\n")
cat("  3. data/cleaned/zone_summary.csv (", nrow(zone_summary), "zones)\n")
cat("  4. data/cleaned/qualification_distribution.csv (", nrow(qualification_dist), "qualifications)\n")
