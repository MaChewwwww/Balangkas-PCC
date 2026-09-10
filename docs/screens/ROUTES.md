# Exact route catalogue

All 41 source page files are accounted for. Bracketed segments are dynamic identifiers. Route groups are omitted from URL paths. Source identifiers refer to the practice repository. Keep URLs and query-origin navigation during onsite reconstruction. /portal/[section] is a compatibility dispatcher, not permission to invent additional product sections.

| URL | Source page identifier | Rendered component references | Feature contract |
| --- | --- | --- | --- |
| /login | frontend_prototype/src/app/(auth)/login/page.tsx | ArrowLeft, ArrowRight, Eye, EyeOff, InputOTP, InputOTPGroup, InputOTPSlot, KeyRound, Link, LoginContent, ShieldCheck, Suspense | [authentication-onboarding](../features/authentication-onboarding.md) |
| /register | frontend_prototype/src/app/(auth)/register/page.tsx | ArrowLeft, ArrowRight, Eye, EyeOff, InputOTP, InputOTPGroup, InputOTPSlot, KeyRound, Link, RegisterContent, ShieldCheck, Suspense, Trophy | [authentication-onboarding](../features/authentication-onboarding.md) |
| /about | frontend_prototype/src/app/(public)/about/page.tsx | ArrowUpRight, Link, Reveal, SectionTitle, Symbol | [public-discovery](../features/public-discovery.md) |
| /certificates/[id] | frontend_prototype/src/app/(public)/certificates/[id]/page.tsx | ArrowLeft, ArrowUpRight, CertificateLookup, Link, ShieldCheck, Trophy, Unavailable | [certificates](../features/certificates.md) |
| /certificates | frontend_prototype/src/app/(public)/certificates/page.tsx | ArrowUpRight, CertificateLookup, Link, ShieldCheck, Star, Trophy | [certificates](../features/certificates.md) |
| / | frontend_prototype/src/app/(public)/page.tsx | ActionLink, ArrowUpRight, Award, CertificateLookup, FeaturedEvent, HeroChampionBackdrop, HeroShield, Link, PlayerRow, Reveal, SectionTitle, ShieldCheck, Swords, TeamMark, TeamRow, TournamentRow | [public-discovery](../features/public-discovery.md) |
| /players/[id] | frontend_prototype/src/app/(public)/players/[id]/page.tsx | ArrowLeft, ArrowUpRight, Link, SectionTitle, ShieldCheck, Status, TeamMark, Unavailable, WinBar | [identity-portfolio](../features/identity-portfolio.md) |
| /players | frontend_prototype/src/app/(public)/players/page.tsx | EmptyState, FilterTabs, PageIntro, PlayerRow, SearchField | [identity-portfolio](../features/identity-portfolio.md) |
| /teams/[id] | frontend_prototype/src/app/(public)/teams/[id]/page.tsx | ActionLink, ArrowLeft, ArrowUpRight, Link, SectionTitle, TeamMark, TournamentRow, Unavailable, WinBar | [teams](../features/teams.md) |
| /teams | frontend_prototype/src/app/(public)/teams/page.tsx | EmptyState, FilterTabs, PageIntro, SearchField, TeamRow | [teams](../features/teams.md) |
| /tournaments/[id] | frontend_prototype/src/app/(public)/tournaments/[id]/page.tsx | TournamentExperience, Unavailable | [tournaments](../features/tournaments.md) |
| /tournaments | frontend_prototype/src/app/(public)/tournaments/page.tsx | EmptyState, FeaturedEvent, FilterSelect, FilterTabs, PageIntro, SearchField, TournamentRow | [tournaments](../features/tournaments.md) |
| /onboarding | frontend_prototype/src/app/onboarding/page.tsx | AlertCircle, ArrowLeft, ArrowRight, Camera, Check, CheckCircle2, Coins, GameId, Gamepad2, OnboardingContent, SchoolSelect, ShieldCheck, Sparkles, Suspense, Trophy, User, Wallet | [authentication-onboarding](../features/authentication-onboarding.md) |
| /portal/[section] | frontend_prototype/src/app/portal/[section]/page.tsx | PortalWorkspace | [notifications-activity](../features/notifications-activity.md) |
| /portal/communities/[id]/manage | frontend_prototype/src/app/portal/communities/[id]/manage/page.tsx | ManageRecord | [communities](../features/communities.md) |
| /portal/communities/[id] | frontend_prototype/src/app/portal/communities/[id]/page.tsx | CommunityDetail | [communities](../features/communities.md) |
| /portal/communities/new | frontend_prototype/src/app/portal/communities/new/page.tsx | CreateRecord | [communities](../features/communities.md) |
| /portal/communities | frontend_prototype/src/app/portal/communities/page.tsx | CommunityDirectory | [communities](../features/communities.md) |
| /portal/match-history | frontend_prototype/src/app/portal/match-history/page.tsx | RecordDirectory | [match-history](../features/match-history.md) |
| /portal/my-team/[id] | frontend_prototype/src/app/portal/my-team/[id]/page.tsx | GenericDetail | [teams](../features/teams.md) |
| /portal/my-team | frontend_prototype/src/app/portal/my-team/page.tsx | RecordDirectory | [teams](../features/teams.md) |
| /portal | frontend_prototype/src/app/portal/page.tsx | PortalWorkspace | [notifications-activity](../features/notifications-activity.md) |
| /portal/players/[id] | frontend_prototype/src/app/portal/players/[id]/page.tsx | PlayerDetail | [identity-portfolio](../features/identity-portfolio.md) |
| /portal/players | frontend_prototype/src/app/portal/players/page.tsx |  | [identity-portfolio](../features/identity-portfolio.md) |
| /portal/portfolio | frontend_prototype/src/app/portal/portfolio/page.tsx | RecordDirectory | [identity-portfolio](../features/identity-portfolio.md) |
| /portal/scrimmages/[id]/manage | frontend_prototype/src/app/portal/scrimmages/[id]/manage/page.tsx |  | [scrimmages](../features/scrimmages.md) |
| /portal/scrimmages/[id] | frontend_prototype/src/app/portal/scrimmages/[id]/page.tsx | GenericDetail | [scrimmages](../features/scrimmages.md) |
| /portal/scrimmages/new | frontend_prototype/src/app/portal/scrimmages/new/page.tsx | CreateRecord | [scrimmages](../features/scrimmages.md) |
| /portal/scrimmages | frontend_prototype/src/app/portal/scrimmages/page.tsx | RecordDirectory | [scrimmages](../features/scrimmages.md) |
| /portal/teams/[id]/join | frontend_prototype/src/app/portal/teams/[id]/join/page.tsx | JoinRecord | [teams](../features/teams.md) |
| /portal/teams/[id]/manage | frontend_prototype/src/app/portal/teams/[id]/manage/page.tsx | ManageRecord | [teams](../features/teams.md) |
| /portal/teams/[id] | frontend_prototype/src/app/portal/teams/[id]/page.tsx | GenericDetail | [teams](../features/teams.md) |
| /portal/teams/new | frontend_prototype/src/app/portal/teams/new/page.tsx | CreateRecord | [teams](../features/teams.md) |
| /portal/teams | frontend_prototype/src/app/portal/teams/page.tsx | RecordDirectory | [teams](../features/teams.md) |
| /portal/tournaments/[id]/join | frontend_prototype/src/app/portal/tournaments/[id]/join/page.tsx | JoinRecord | [tournaments](../features/tournaments.md) |
| /portal/tournaments/[id]/manage | frontend_prototype/src/app/portal/tournaments/[id]/manage/page.tsx | ManageRecord | [tournaments](../features/tournaments.md) |
| /portal/tournaments/[id]/matches/[matchId] | frontend_prototype/src/app/portal/tournaments/[id]/matches/[matchId]/page.tsx | TournamentMatchView | [tournaments](../features/tournaments.md) |
| /portal/tournaments/[id] | frontend_prototype/src/app/portal/tournaments/[id]/page.tsx | GenericDetail | [tournaments](../features/tournaments.md) |
| /portal/tournaments/[id]/teams/[teamId] | frontend_prototype/src/app/portal/tournaments/[id]/teams/[teamId]/page.tsx | TournamentTeamView | [tournaments](../features/tournaments.md) |
| /portal/tournaments/new | frontend_prototype/src/app/portal/tournaments/new/page.tsx | CreateRecord | [tournaments](../features/tournaments.md) |
| /portal/tournaments | frontend_prototype/src/app/portal/tournaments/page.tsx | RecordDirectory | [tournaments](../features/tournaments.md) |
