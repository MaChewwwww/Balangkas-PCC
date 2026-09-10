# Frontend store action inventory

Every named Store member from the practice mock-store is listed. Methods are reference names only; do not reproduce local storage logic. Data selectors become permission-filtered query projections. Draft/UI preference state may stay local; official domain state may not.

| Member | PCC contract responsibility |
| --- | --- |
| db | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| currentPlayer | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| activeTeamId | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| setActiveTeamId | UI preference or session lifecycle; never resets server business data. |
| updateProfile | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| createTeam | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| updateTeam | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| joinTeam | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| archiveTeam | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| createCommunity | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| updateCommunity | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| archiveCommunity | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| joinCommunity | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| addCommunityPost | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| reactToPost | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| commentOnPost | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| createTournament | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| updateTournament | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| archiveTournament | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| reactToTournament | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| addTournamentAnnouncement | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| advanceTournamentStage | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| generateTournamentBracket | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| registerTeam | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| withdrawRegistration | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| updateMatch | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| recordMatchGame | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| attachMatchEvidence | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| attachGameEvidence | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| shuffleTournamentSeeds | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| startTournament | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| endTournament | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| addTournamentManager | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| removeTournamentManager | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| createScrimmage | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| updateScrimmage | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| acceptScrimmageChallenge | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| declineScrimmageChallenge | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| comment | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| proposeResult | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| saveReward | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| issueCertificate | Map to the corresponding feature API mutation/query; server actor, version, validation and audit required. |
| reset | UI preference or session lifecycle; never resets server business data. |
| logout | UI preference or session lifecycle; never resets server business data. |
