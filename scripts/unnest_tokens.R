library(tidyverse)
library(tidytext)

raw_text <- tibble(section = "6.1 Clinical Trial Experience
  Because clinical trials are conducted under widely varying conditions, adverse reaction rates observed in clinical trials of a drug cannot be directly compared to rates in the clinical trials of another drug and may not reflect the rates observed in practice.
                   The data below reflect exposure to ARDECRETRIS as monotherapy in 327 patients with classical Hodgkin lymphoma (HL) and systemic anaplastic large cell lymphoma (sALCL), including 160 patients in two uncontrolled single-arm trials (Studies 1 and 2) and 167 patients in one placebo-controlled randomized trial (Study 3).
                   In Studies 1 and 2, the most common adverse reactions were neutropenia, fatigue, nausea, anemia, cough, and vomiting."
)

tidy_text <- raw_text %>%
  mutate(section = str_replace_all(section, "\\n", "")) %>%
  unnest_tokens(
    output = sentence,
    input = section,
    token = "sentences",
    drop = FALSE,
    to_lower = FALSE
    ) %>%
  mutate(
    regex = str_replace_all(sentence, "\\(", "\\\\("),
    regex = str_replace_all(regex, "\\)", "\\\\)"),
    regex = str_replace_all(regex, "\\.", "\\\\.")
  ) %>%
  mutate(
    start = str_locate(section, regex)[, 1],
    end = str_locate(section, regex)[, 2]
  ) %>%
  select(sentence, start, end) %>%
  print()
