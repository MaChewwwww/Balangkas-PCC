# Screen control and field inventory

Documented labels, placeholders, accessible names and handler names support the authored screen descriptions. A handler name is a documentation label, not an implementation prescription. Dynamic captions are captured in the feature/screen specification rather than copied JSX.

Legacy demonstration copy is evidence for visual hierarchy and wording rhythm only. It never authorizes PCC to claim a biometric verification, wallet linkage, credential mint, escrow, or provider result that the server cannot prove. Where the prototype says `mint` or `mint address`, PCC keeps the field position and typography but renders **Core asset address** from recorded finalized Metaplex Core evidence. A screen may describe the credential standard as a Metaplex Core NFT, but never calls its address a mint address.


## page



| Kind | Caption/reference |
| --- | --- |
| UI text | e.g. athlete@balangkas.gg or student@dlsu.edu.ph |
| UI text | Enter your account password |
| UI text | Email Address |
| UI text | Password |
| UI text | Sign in to Balangkas |
| Action reference | handleCredentialsSubmit |
| Action reference | handleVerifyOtp |

## page



| Kind | Caption/reference |
| --- | --- |
| UI text | e.g. player@university.edu.ph |
| UI text | At least 8 characters |
| UI text | Re-enter your password |
| UI text | Email Address |
| UI text | Password |
| UI text | Confirm Password |
| UI text | Create your Account |
| Action reference | handleCredentialsSubmit |
| Action reference | handleVerifyOtp |

## page



| Kind | Caption/reference |
| --- | --- |
| UI text | The game deserves better. |
| UI text | Built with a shared ambition. |
| UI text | More than the final score. |

## page



| Kind | Caption/reference |
| --- | --- |
| UI text | The proof behind the play |
| UI text | Great games. Lasting recognition. |
| Source UI text | Find a tournament credential by its certificate ID or exact Solana mint address. PCC renders `Core asset address` in the same control. |
| UI text | Most valuable player |
| UI text | Championship credential |
| UI text | Illustrative credentials; this prototype does not perform live blockchain verification. |

## page



| Kind | Caption/reference |
| --- | --- |
| UI text | Certificate lookup |
| UI text | Certificate of achievement |
| UI text | A record of achievement |
| UI text | The story behind the credential. |
| UI text | Recipient / Team / Award / Issued |
| UI text | Explore verification information |
| Source UI text | Network / Credential standard / Sample mint address / Sample transaction reference. PCC renders `Core asset address` and server-recorded finalized evidence. |
| UI text | Open Devnet Explorer |

## page



| Kind | Caption/reference |
| --- | --- |
| UI text | Your next arena awaits. |
| UI text | Teams making their mark. |
| UI text | Remember these names. |
| UI text | Less friction. More game. |
| UI text | BALANGKAS |
| UI text | From the first scrim to the record that follows. |

## page



| Kind | Caption/reference |
| --- | --- |
| UI text | Their heroes. Their game. |
| UI text | Moments that matter. |
| UI text | The match record. |

## page



| Kind | Caption/reference |
| --- | --- |
| UI text | The next name to know. |
| UI text | Player name, team, or university… |

## page



| Kind | Caption/reference |
| --- | --- |
| UI text | Stronger together. |
| UI text | On the circuit. |

## page



| Kind | Caption/reference |
| --- | --- |
| UI text | Find your kind of team. |
| UI text | Team, tag, university, or player… |

## page



| Kind | Caption/reference |
| --- | --- |
| UI text | Pick your next stage. |
| UI text | Tournament, organizer, game, or tier… |

## page



| Kind | Caption/reference |
| --- | --- |
| UI text | e.g. PhantomSlayer or KarlTzy |
| UI text | Search 2,300+ accredited institutions (e.g. DLSU, PUP, UST)... |
| UI text | e.g. 192847102 |
| UI text | e.g. 3029 |
| UI text | e.g. Senior varsity Gold Laner aiming for the PCC 2026 National Championship. Specializes in hyper-carry scaling and macro teamfight positioning. |
| UI text | In-Game Name (IGN) |
| UI text | Collegiate Institution / School |
| UI text | MLBB User ID |
| UI text | Server / Zone ID (4 Digits) |
| UI text | Primary Roster Role |
| UI text | Current Competitive Rank |
| UI text | Short Description |
| UI text | Build your Athlete Profile |
| UI text | Anti-Smurf Biometric Integrity Check |
| UI text | Prize Escrow & Soulbound Credential Wallet |
| UI text | Athlete Profile Created! |
| Action reference | handleProceedToBiometrics |
| Action reference | handleStartScan |
| Action reference | handleConnectWallet |

## AuthLayout



| Kind | Caption/reference |
| --- | --- |
| UI text | Back to Balangkas.gg |
| UI text | Leveling the Bracket for Grassroots Esports. |
| UI text | Active National Circuit |
| UI text | Philippine Collegiate Championship 2026 |
| Legacy visual copy | Anti-Smurf Biometric Fair Play / Metaplex Core Credentials / Smart Escrow Prize Pools — render only policy-backed PCC wording and actual readiness state. |

## CertificateSearchBar



| Kind | Caption/reference |
| --- | --- |
| UI text | Verify Certificate... |

## CommunitiesWorkspace



| Kind | Caption/reference |
| --- | --- |
| UI text | Search 2,300+ accredited institutions (e.g. DLSU, PUP, UST)... |
| UI text | Invite Code |
| UI text | Community Settings |
| UI text | Share a scrim schedule, scouting note, or campus announcement... |
| UI text | Remove Image |
| UI text | Write a comment... (Press Enter to reply) |
| UI text | Search teams by name, university, or tag... |
| UI text | Search athletes by IGN, real name, university, or team... |
| UI text | Clear search |
| UI text | Search stages by tournament name, season, or participating squad... |
| UI text | Collegiate & Grassroots Hubs |
| UI text | Close modal |
| UI text | e.g. DLSU Esports Collective |
| UI text | Share your community's goals, competitive focus, or campus scrim schedules... |
| UI text | e.g. Collegiate, MLBB, Metro Manila |
| UI text | Description |
| UI text | Discovery Tags (Comma-separated) |
| UI text | Hub Settings & Visual Identity |
| UI text | Archive Community Hub |
| UI text | Publish Community Update |
| UI text | Create Community Hub |
| Action reference | handlePostImageUpload |
| Action reference | handleImageUpload |
| Action reference | handleManageImageUpload |
| Action reference | handleCopy |
| Action reference | handleCreate |
| Action reference | handleSaveManage |
| Action reference | handleArchiveCommunity |

## CreateTeamModal



| Kind | Caption/reference |
| --- | --- |
| UI text | Close |
| UI text | Remove custom image and show presets |
| UI text | Team name |
| UI text | e.g. DLSU Viridis Arcus |
| UI text | Tag |
| UI text | e.g. VA |
| UI text | Search 2,300+ accredited Philippine institutions... |
| UI text | Describe your team (e.g., Objective-focused early game rotation, mythic glory tournament roster)... |
| UI text | Affiliated Community Hub (Optional) |
| UI text | Team Description |
| UI text | New Team |
| Action reference | handleLogoUpload |
| Action reference | handleCreate |

## CustomSelect



| Kind | Caption/reference |
| --- | --- |
| Action reference | handleClickOutside |
| Action reference | handleKeyDown |

## JoinTeamModal



| Kind | Caption/reference |
| --- | --- |
| UI text | Close |
| UI text | Enter code (e.g. GRC-9901 or VA-7842) |
| UI text | Join Competitive Squad |
| Action reference | handleSubmit |

## MatchHistoryWorkspace



| Kind | Caption/reference |
| --- | --- |
| UI text | Match History |
| UI text | Search opponent, event, or MVP... |
| UI text | No Matches Found |
| UI text | No Tournaments Found |
| UI text | No Opponents Found |
| UI text | Competitive Arena |

## MyTeamWorkspace



| Kind | Caption/reference |
| --- | --- |
| UI text | My Teams and Past Affiliations |
| UI text | Active Verified Roster |
| UI text | Team Captain |
| UI text | Concluded Career Tenure |
| UI text | Search teams by name, tag, or school... |
| UI text | No Active Teams Found |
| UI text | No Previous Teams Found |
| UI text | Create Your Team |
| Action reference | handleCopyCode |

## OverviewWorkspace



| Kind | Caption/reference |
| --- | --- |
| UI text | Key Performance Indicators |
| UI text | Hosted Stages & Competitions |
| UI text | Open Practice Blocks |
| UI text | Operations Launchpad |
| UI text | Recent Activity |

## PlayerDataWorkspace



| Kind | Caption/reference |
| --- | --- |
| UI text | Copy Solana Wallet Address |
| UI text | View match details |
| UI text | View tournament details |
| UI text | Copy wallet address |
| UI text | Player Record Not Found |
| UI text | Recent Competitive Matches |
| UI text | Achievements & Awards |
| UI text | Signature Hero Mastery |
| UI text | Affiliated Squad |
| UI text | SOLANA Blockchain |
| Action reference | handleCopyWallet |

## PortalNotifications



| Kind | Caption/reference |
| --- | --- |
| UI text | Notifications Flyout |
| UI text | Mark all notifications as read |
| UI text | Unread |
| UI text | Dismiss notification |
| Action reference | handleClickOutside |
| Action reference | handleKeyDown |
| Action reference | handleMarkAllAsRead |
| Action reference | handleMarkAsRead |
| Action reference | handleDismiss |

## PortalShell



| Kind | Caption/reference |
| --- | --- |
| UI text | Public Page |
| UI text | Sign out of Balangkas Portal |
| UI text | Sign out |
| UI text | Breadcrumb |
| UI text | Athlete Passport & Dossier |
| UI text | Verified & Online |
| UI text | Mobile Navigation |
| Action reference | handleLogout |

## PortalToolbar



| Kind | Caption/reference |
| --- | --- |
| UI text | Clear search |

## OnboardingContext



| Kind | Caption/reference |
| --- | --- |
| UI text | Getting started for [tournament name] |
| UI text | Back to tournament |
| Legacy visual copy | The source calls this a mock onboarding journey; PCC retains valid tournament context but must state the actual registration/readiness outcome. |

## PortfolioWorkspace



| Kind | Caption/reference |
| --- | --- |
| UI text | Search 2,300+ accredited Philippine institutions... |
| UI text | e.g. 7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU |
| UI text | Search credentials or matches... |
| UI text | In-Game Name (IGN) |
| UI text | Real Name |
| UI text | Higher Education Institution (HEI) |
| UI text | Bio Note |
| UI text | Solana Devnet Address |
| UI text | Personal Information & Visibility |
| UI text | Solana Devnet Credential Wallet |
| UI text | Hero Mastery & Combat Proficiency |
| UI text | Recent Competitive Matches |
| UI text | Competitive Arena |
| Action reference | handleSaveProfile |
| Action reference | handleVerifyBiometrics |

## SchoolSelect



| Kind | Caption/reference |
| --- | --- |
| UI text | Clear selection |
| UI text | Clear selected institution |
| UI text | Type school or acronym (e.g. DLSU, PUP, UST)... |
| Action reference | handleClickOutside |
| Action reference | handleSelect |
| Action reference | handleClear |
| Action reference | handleKeyDown |

## ScrimmagesWorkspace



| Kind | Caption/reference |
| --- | --- |
| UI text | Close modal |
| UI text | e.g. Mythic Glory+ |
| UI text | e.g. 109283741 (3021) |
| UI text | e.g. 7721 (optional) |
| UI text | e.g. BO3 series, focus on macro draft testing and lord contest... |
| UI text | Send coordination note... (Enter) |
| UI text | Send message |
| UI text | Scrimmage Board |
| UI text | Search squad, rank, notes... |
| UI text | Lobby Code |
| UI text | Edit Scrimmage Request |
| UI text | Awaiting Opponent Squad Confirmation |
| UI text | Submit Match Result |
| UI text | No practice blocks found |
| UI text | Pinned Active Scrimmages |
| UI text | Scrimmage Matchmaking |
| UI text | Request a Scrimmage |
| UI text | Request Scrimmage |
| UI text | Verify Squad Challenge |
| Action reference | handleCreate |
| Action reference | handleOpenChallengeModal |
| Action reference | handleConfirmChallenge |
| Action reference | handleAcceptChallenge |
| Action reference | handleSendChat |
| Action reference | handleSimulateOcrUpload (documentation label only; PCC uploads private evidence and enqueues local extraction) |
| Action reference | handleSubmitResult |
| Action reference | handleCopyLobby |
| Action reference | handleUpdateManage |

## TeamDataWorkspace



| Kind | Caption/reference |
| --- | --- |
| UI text | e.g. GRC-9901 |
| UI text | Copy team invite code |
| UI text | Share public team dossier link |
| UI text | View match details |
| UI text | Copy certificate identifier |
| Source UI text | Copy full mint address. PCC renders `Copy Core asset address`. |
| UI text | Open on Solana Explorer |
| UI text | Member record synced through team roster |
| UI text | Team Record Not Found |
| UI text | Restricted Squad Dossier |
| UI text | Recent Competitive Matches |
| UI text | Achievements & Awards |
| UI text | Active Squad Lineup |
| UI text | Tactical Analytics |
| Action reference | handleCopyText |
| Action reference | handleUnlockPrivateTeam |
| Action reference | handleShare |

## TeamsWorkspace



| Kind | Caption/reference |
| --- | --- |
| UI text | Competitive Teams |
| UI text | Search teams by name, tag, or school... |
| UI text | Close |
| UI text | Remove custom image and show presets |
| UI text | Team name |
| UI text | e.g. DLSU Viridis Arcus |
| UI text | Tag |
| UI text | e.g. VA |
| UI text | Search 2,300+ accredited Philippine institutions... |
| UI text | Describe your team (e.g., Objective-focused early game rotation, mythic glory tournament roster)... |
| UI text | Remove custom image |
| UI text | Brief description of your team, playstyle, or competitive goals... |
| UI text | Player actions |
| UI text | Player profile not found |
| UI text | Reserve actions |
| UI text | Close dialog |
| UI text | Affiliated Community Hub (Optional) |
| UI text | Team Description |
| UI text | Affiliated Community Hub |
| UI text | Unauthorized Access |
| UI text | Create Your Team |
| UI text | Create Competition Team |
| UI text | Team Logo |
| UI text | Team Details |
| UI text | Team Lineup |
| UI text | Substitutes & Reserves |
| UI text | Team Invite Code |
| UI text | Save Team Changes? |
| Action reference | handleLogoUpload |
| Action reference | handleCreate |
| Action reference | handleArchive |
| Action reference | handlePromptSave |
| Action reference | handleConfirmSave |
| Action reference | handleRegenerateKey |
| Action reference | handleTransferCaptain |
| Action reference | handleSetManager |
| Action reference | handleSetCoach |
| Action reference | handleRemoveMember |
| Action reference | handleAddMember |
| Action reference | handleSharePass |

## TournamentCommandCenter



| Kind | Caption/reference |
| --- | --- |
| UI text | Tournament command center tabs |
| UI text | Tournament management team |
| UI text | Management member |
| UI text | Management role |
| UI text | Custom management role |
| UI text | e.g. Broadcast Director |
| UI text | Stage performance |
| UI text | Tournament History |
| UI text | Registered teams |
| UI text | Team filters |
| UI text | Registration metrics |
| UI text | Single-elimination bracket preview |
| UI text | Match operations |
| UI text | Open match dossier |
| UI text | Match filters |
| UI text | Match metrics |
| UI text | Reward views |
| UI text | Team Placement Rewards |
| UI text | Tournament Certificates |
| UI text | Search & filters |
| UI text | Search recipients |
| UI text | Reward metrics |
| UI text | Select participant |
| UI text | Credential title |
| UI text | e.g. Philippine Collegiate Championship - MVP |
| UI text | Recipient wallet |
| UI text | Certificate remarks |
| UI text | Special merit citation, match highlights, or commissioner statement... |
| UI text | Reward amount |
| UI text | e.g. 15,000 |
| UI text | Reward destination reference |
| UI text | Select active roster representative |
| UI text | Reward memo |
| UI text | e.g. Grand finals placement allocation |
| UI text | Clear search |
| UI text | Bracket progression connections |
| UI text | Target Recipient |
| UI text | Award Honor |
| UI text | Solana Network |
| UI text | Credential Title |
| UI text | Citation Remarks (Optional) |
| UI text | Placement |
| UI text | Reward Rail |
| UI text | Active roster representative |
| UI text | Calculation basis / memo |
| UI text | Series won |
| UI text | Issue Official Credential |
| Action reference | handleStart |
| Action reference | handleEnd |
| Action reference | handleAddManager |
| Action reference | handleOpenCertModal |
| Action reference | handleConfirmIssueCert |
| Action reference | handleOpenRewardModal |
| Action reference | handleConfirmReward |

## TournamentMatchContext



| Kind | Caption/reference |
| --- | --- |
| UI text | Match views |
| UI text | Match overview |
| UI text | Game record |
| UI text | Aggregate comparison |
| UI text | Game evidence |
| UI text | Record game result |
| UI text | Player statistics |
| Action reference | handleGameEvidence |

## TournamentsWorkspace



| Kind | Caption/reference |
| --- | --- |
| UI text | Copy private tournament invite code |
| UI text | Tournament settings |
| UI text | Cheer for this tournament |
| UI text | Award trophy reaction |
| UI text | Hype fire reaction |
| UI text | Bulletin Headline (e.g. Schedule update or referee assignment) |
| UI text | Announcement details... |
| UI text | Champion wallet address |
| UI text | Runner-up wallet address |
| UI text | Leave empty if not awarded |
| UI text | Ask tournament organizers, coordinate match lobbies, or cheer for your school... |
| UI text | Close tournament settings |
| UI text | e.g. Philippine Collegiate Championship Season 1 |
| UI text | Detail the tournament rules, eligibility criteria, match reporting requirements, and schedule breakdown... |
| UI text | e.g. PCC-PRIVATE-2026 |
| UI text | Remove custom pubmat |
| UI text | e.g. VISAYAS-INV-2026 |
| UI text | Tournaments |
| UI text | Previous tournament |
| UI text | Next tournament |
| UI text | Search tournaments, games, organizers... |
| UI text | Feed view |
| UI text | Grid view |
| UI text | Table view |
| UI text | Cheer |
| UI text | Fire |
| UI text | Trophy |
| UI text | Close |
| UI text | e.g. BALANGKAS-PRO-2026 or CYBER-INV-2026 |
| UI text | Stage Lifecycle Progression |
| UI text | Credential Title |
| UI text | Award Honor |
| UI text | End Date |
| UI text | Entry Fee (Mode) |
| UI text | Tournament Pubmat / Banner |
| UI text | Select Active Squad |
| UI text | Tournament Record Not Found |
| UI text | Tournament Director Desk |
| UI text | Biometrically Protected Roster Protocol |
| UI text | Stage Milestones |
| UI text | Stage Rules & Specs |
| UI text | Challonge Visual Match Tree |
| UI text | No scheduled matchups yet |
| UI text | Solana Devnet Credential Issuer |
| UI text | Official Tournament Bulletins |
| UI text | Participant Discussion Stream |
| UI text | Referee Scoreboard Review |
| UI text | Edit Tournament |
| UI text | Register Squad |
| UI text | Create Tournament |
| UI text | Join via Invite Code |
| Action reference | handlePubmatFile |
| Action reference | handleJoinViaInviteCode |
| Action reference | handlePublishTournament |
| Action reference | handleShare |
| Action reference | handleJoinTournament |
| Action reference | handleCopyPrivateInviteCode |
| Action reference | handleOpenSettings |
| Action reference | handleSaveTournamentSettings |

## TournamentTeamContext



| Kind | Caption/reference |
| --- | --- |
| UI text | Biometrically verified competitor |
| UI text | Verified team members |
| UI text | Tournament match record |
| UI text | Team credentials |
| UI text | Historical team record |

## AmbientCyberSpotlight



| Kind | Caption/reference |
| --- | --- |
| Action reference | handleMouseMove |
| Action reference | handleMouseLeave |
| Action reference | handleMouseEnter |

## HeroShield



| Kind | Caption/reference |
| --- | --- |
| UI text | Dimensional Balangkas shield |

## primitives



| Kind | Caption/reference |
| --- | --- |
| UI text | Verified athlete |
| UI text | Look up certificate |
| Source UI text | Certificate ID or mint address. PCC renders `Certificate ID or Core asset address`. |

## PublicShell



| Kind | Caption/reference |
| --- | --- |
| UI text | Balangkas home |
| UI text | Main navigation |
| UI text | Open navigation |
| UI text | Close navigation |
| UI text | Mobile navigation |
| UI text | Footer navigation |

## TournamentExperience



| Kind | Caption/reference |
| --- | --- |
| UI text | Tournament sections |
| UI text | Every match matters. |
| UI text | Tournament bracket, scroll horizontally for more rounds |
| UI text | The bracket is taking shape. |
| UI text | Meet the competition. |
| UI text | Rosters coming soon. |
| UI text | Close match record |
| UI text | The stage is set. |
| UI text | Fair play comes first. |
| UI text | Competition guide |
| UI text | From scoreboard to match record. |
| UI text | Recognition that stays. |
