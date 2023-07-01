library(hoopR)
setwd('C:/Users/khira/OneDrive/Documents/NCAAMB')

seasons = seq(2006, 2023)

mbb_schedule = load_mbb_schedule(seasons = seasons)
saveRDS(mbb_schedule, file = './NCAAMB_Schedule.Rda')

team_box = load_mbb_team_box(seasons = seasons)
saveRDS(team_box, file = './NCAAMB_TeamBox.Rda')

player_box = load_mbb_player_box(seasons = seasons)
saveRDS(player_box, file = './NCAAMB_PlayerBox.Rda')

conferences = espn_mbb_conferences()
saveRDS(conferences, file = './NCAAMB_ConferenceDirectory.Rda')

TeamConferenceDirectory = 
  mbb_schedule %>% 
  filter(home_id != 'TBD' & is.na(home_conference_id) == FALSE) %>% 
  group_by(season, home_id, home_short_display_name, home_conference_id) %>% 
  summarise() %>%
  left_join(conferences, by = c('home_conference_id' = 'group_id')) %>%
  select(
    Season = season, 
    TeamID = home_id, 
    TeamName = home_short_display_name, 
    ConferenceID = home_conference_id, 
    ConferenceName = short_name) %>%
  ungroup()
saveRDS(TeamConferenceDirectory, file = './NCAAMB_TeamConferenceDirectory.Rda')


#play_by_play = load_mbb_pbp(seasons = seasons)
#saveRDS(play_by_play, file = 'C:/Users/khira/OneDrive/Documents/NCAAMB/NCAAMB_PlayByPlay.Rda')

rm(seasons)
rm(mbb_schedule)
rm(team_box)
rm(player_box)
rm(conferences)
rm(TeamConferenceDirectory)
#rm(play_by_play)

print("NCAA Mens Basketball Data Updated")
