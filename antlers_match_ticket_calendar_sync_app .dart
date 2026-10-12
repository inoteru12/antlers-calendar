import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const AntlersCalendarApp());
}

enum CompetitionType { j1League, levainCup, emperorsCup, acl }

class TicketPhase {
  final String title; // 例: SÓCIO先行, ファンクラブ先行, 一般販売
  final DateTime saleDate;
  final String targetAudience;
  bool isCalendarSynced;
  bool isNotificationEnabled;

  TicketPhase({
    required this.title,
    required this.saleDate,
    required this.targetAudience,
    this.isCalendarSynced = false,
    this.isNotificationEnabled = true,
  });
}

class MatchReview {
  int kashimaScore;
  int opponentScore;
  String watchStyle; // カシマ現地, アウェイ現地, DAZN, PV
  int rating; // 1〜5
  String myMom; // Man of the Match
  String comment;

  MatchReview({
    this.kashimaScore = 0,
    this.opponentScore = 0,
    this.watchStyle = '現地観戦 (カシマスタジアム)',
    this.rating = 5,
    this.myMom = '',
    this.comment = '',
  });

  String generateSnsPostText(AntlersMatch match) {
    final stars = '⭐' * rating;
    return '【鹿島アントラーズ 観戦ログ】\n'
        '${match.competitionName}\n'
        '🦌 鹿島 $kashimaScore - $opponentScore ${match.opponent}\n'
        '📍 観戦スタイル: $watchStyle\n'
        '⭐ 満足度: $stars\n'
        '${myMom.isNotEmpty ? "👑 マイMOM: $myMom\n" : ""}'
        '${comment.isNotEmpty ? "💬 感想: $comment\n" : ""}'
        '\n#antlers #鹿島アントラーズ #カシマスタジアム';
  }
}

class AntlersMatch {
  final String id;
  final String opponent;
  final String opponentShort;
  final bool isHome;
  final CompetitionType competition;
  final String stadium;
  final DateTime kickOff;
  final List<TicketPhase> ticketPhases;
  final String ticketUrl;
  bool isCalendarSynced;
  bool isKickoffNotificationEnabled;
  bool isFavorite;
  bool isFinished;
  MatchReview? review;

  AntlersMatch({
    required this.id,
    required this.opponent,
    required this.opponentShort,
    required this.isHome,
    required this.competition,
    required this.stadium,
    required this.kickOff,
    required this.ticketPhases,
    this.ticketUrl = 'https://www.jleague-ticket.jp/club/ka/',
    this.isCalendarSynced = false,
    this.isKickoffNotificationEnabled = true,
    this.isFavorite = false,
    this.isFinished = false,
    this.review,
  });

  String get competitionName {
    switch (competition) {
      case CompetitionType.j1League:
        return '2026 明治安田J1リーグ';
      case CompetitionType.levainCup:
        return 'JリーグYBCルヴァンカップ';
      case CompetitionType.emperorsCup:
        return '天皇杯 JFA 全日本サッカー選手権';
      case CompetitionType.acl:
        return 'AFC チャンピオンズリーグ';
    }
  }
}

class AntlersScheduleRepository {
  static List<AntlersMatch> getSampleMatches() {
    final now = DateTime.now();

    return [
      AntlersMatch(
        id: 'kashima-2026-00',
        opponent: 'アルビレックス新潟',
        opponentShort: '新潟',
        isHome: true,
        competition: CompetitionType.j1League,
        stadium: '県立カシマサッカースタジアム',
        kickOff: now.subtract(const Duration(days: 7, hours: 4)),
        isFinished: true,
        review: MatchReview(
          kashimaScore: 2,
          opponentScore: 1,
          watchStyle: '現地観戦 (カシマスタジアム)',
          rating: 5,
          myMom: '鈴木優磨',
          comment: 'カシマ現地観戦！もつ煮を食べてからの劇的勝利で最高の週末！',
        ),
        ticketPhases: [
          TicketPhase(
            title: '一般販売',
            saleDate: now.subtract(const Duration(days: 20)),
            targetAudience: '一般・全会員対象',
            isCalendarSynced: true,
          ),
        ],
        isCalendarSynced: true,
      ),
      AntlersMatch(
        id: 'kashima-2026-01',
        opponent: '浦和レッズ',
        opponentShort: '浦和',
        isHome: true,
        competition: CompetitionType.j1League,
        stadium: '県立カシマサッカースタジアム',
        kickOff: now.add(const Duration(days: 4, hours: 14)),
        ticketPhases: [
          TicketPhase(
            title: 'SÓCIO先行販売',
            saleDate: now.subtract(const Duration(days: 10)),
            targetAudience: '年間シートホルダー',
            isCalendarSynced: true,
            isNotificationEnabled: true,
          ),
          TicketPhase(
            title: 'ファンクラブ会員先行',
            saleDate: now.subtract(const Duration(days: 7)),
            targetAudience: 'フリークスメンバー',
            isCalendarSynced: true,
            isNotificationEnabled: true,
          ),
          TicketPhase(
            title: '一般販売',
            saleDate: now.subtract(const Duration(days: 3)),
            targetAudience: '一般・全会員対象',
            isCalendarSynced: true,
            isNotificationEnabled: true,
          ),
        ],
        isCalendarSynced: true,
        isKickoffNotificationEnabled: true,
        isFavorite: true,
      ),
      AntlersMatch(
        id: 'kashima-2026-02',
        opponent: '川崎フロンターレ',
        opponentShort: '川崎F',
        isHome: false,
        competition: CompetitionType.j1League,
        stadium: 'Uvanceとどろきスタジアム by Fujitsu',
        kickOff: now.add(const Duration(days: 11, hours: 19)),
        ticketPhases: [
          TicketPhase(
            title: 'アウェイ一般発売',
            saleDate: now.add(const Duration(days: 1, hours: 10)),
            targetAudience: 'ビジター席販売',
            isCalendarSynced: false,
            isNotificationEnabled: true,
          ),
        ],
        isCalendarSynced: false,
        isKickoffNotificationEnabled: true,
        isFavorite: false,
      ),
      AntlersMatch(
        id: 'kashima-2026-03',
        opponent: '横浜F・マリノス',
        opponentShort: '横浜FM',
        isHome: true,
        competition: CompetitionType.j1League,
        stadium: '県立カシマサッカースタジアム',
        kickOff: now.add(const Duration(days: 18, hours: 15)),
        ticketPhases: [
          TicketPhase(
            title: 'SÓCIO先行販売',
            saleDate: now.add(const Duration(days: 5, hours: 10)),
            targetAudience: 'SÓCIO全区分',
            isCalendarSynced: false,
            isNotificationEnabled: true,
          ),
          TicketPhase(
            title: 'ファンクラブ先行販売',
            saleDate: now.add(const Duration(days: 7, hours: 10)),
            targetAudience: 'シーズンチケット/フリークス',
            isCalendarSynced: false,
            isNotificationEnabled: true,
          ),
          TicketPhase(
            title: '一般販売',
            saleDate: now.add(const Duration(days: 9, hours: 10)),
            targetAudience: '一般購入枠',
            isCalendarSynced: false,
            isNotificationEnabled: true,
          ),
        ],
        isCalendarSynced: false,
        isKickoffNotificationEnabled: true,
        isFavorite: true,
      ),
      AntlersMatch(
        id: 'kashima-2026-04',
        opponent: 'FC東京',
        opponentShort: 'FC東京',
        isHome: true,
        competition: CompetitionType.levainCup,
        stadium: '県立カシマサッカースタジアム',
        kickOff: now.add(const Duration(days: 25, hours: 19)),
        ticketPhases: [
          TicketPhase(
            title: 'SÓCIO先行販売',
            saleDate: now.add(const Duration(days: 12, hours: 10)),
            targetAudience: 'SÓCIO限定',
            isCalendarSynced: false,
            isNotificationEnabled: true,
          ),
          TicketPhase(
            title: 'ファンクラブ先行販売',
            saleDate: now.add(const Duration(days: 14, hours: 10)),
            targetAudience: 'フリークス会員',
            isCalendarSynced: false,
            isNotificationEnabled: true,
          ),
          TicketPhase(
            title: '一般販売',
            saleDate: now.add(const Duration(days: 16, hours: 10)),
            targetAudience: '一般購入枠',
            isCalendarSynced: false,
            isNotificationEnabled: false,
          ),
        ],
        isCalendarSynced: false,
        isKickoffNotificationEnabled: false,
        isFavorite: false,
      ),
      AntlersMatch(
        id: 'kashima-2026-05',
        opponent: 'ガンバ大阪',
        opponentShort: 'G大阪',
        isHome: false,
        competition: CompetitionType.j1League,
        stadium: 'パナソニック スタジアム 吹田',
        kickOff: now.add(const Duration(days: 32, hours: 14)),
        ticketPhases: [
          TicketPhase(
            title: 'アウェイ一般発売',
            saleDate: now.add(const Duration(days: 20, hours: 10)),
            targetAudience: 'ビジター席販売',
            isCalendarSynced: false,
            isNotificationEnabled: true,
          ),
        ],
        isCalendarSynced: false,
        isKickoffNotificationEnabled: true,
        isFavorite: false,
      ),
    ];
  }
}

class AntlersTheme {
  // 鹿島アントラーズのディープレッド＆ネイビー
  static const Color primaryRed = Color(0xFF9E0B0F); // Antlers Deep Red
  static const Color darkRed = Color(0xFF6F0000);
  static const Color navyDark = Color(0xFF001128); // Antlers Navy
  static const Color accentGold = Color(0xFFD4AF37); // Antlers Champion Gold
  static const Color bgGrey = Color(0xFFF7F8FA);
  static const Color cardBg = Colors.white;
  static const Color textMain = Color(0xFF1E2124);
  static const Color textMuted = Color(0xFF707684);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryRed,
        primary: primaryRed,
        secondary: navyDark,
        surface: bgGrey,
      ),
      scaffoldBackgroundColor: bgGrey,
      appBarTheme: const AppBarTheme(
        backgroundColor: navyDark,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardTheme(
        color: cardBg,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

class AntlersCalendarApp extends StatelessWidget {
  const AntlersCalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Antlers Schedule Sync',
      debugShowCheckedModeBanner: false,
      theme: AntlersTheme.lightTheme,
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  late List<AntlersMatch> _matches;
  String _selectedCalendar = 'Apple カレンダー (鹿島公式)';
  bool _autoSyncEnabled = true;
  int _notifyKickoffHoursBefore = 2;
  int _notifyTicketMinutesBefore = 15;

  @override
  void initState() {
    super.initState();
    _matches = AntlersScheduleRepository.getSampleMatches();
  }

  void _toggleCalendarSync(AntlersMatch match) {
    setState(() {
      match.isCalendarSynced = !match.isCalendarSynced;
      // チケットフェーズも同時に連動
      for (var phase in match.ticketPhases) {
        phase.isCalendarSynced = match.isCalendarSynced;
      }
    });

    final action = match.isCalendarSynced ? 'カレンダーに追加' : 'カレンダーから削除';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${match.opponent}戦（${match.isHome ? "HOME" : "AWAY"}）を$actionしました'),
        backgroundColor: match.isCalendarSynced ? AntlersTheme.primaryRed : Colors.grey[800],
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: '詳細確認',
          textColor: AntlersTheme.accentGold,
          onPressed: () => _showMatchDetail(match),
        ),
      ),
    );
  }

  void _syncAllMatches() {
    setState(() {
      for (var m in _matches) {
        m.isCalendarSynced = true;
        for (var p in m.ticketPhases) {
          p.isCalendarSynced = true;
        }
      }
    });

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: const [
            Icon(Icons.check_circle, color: AntlersTheme.primaryRed),
            SizedBox(width: 8),
            Text('カレンダー一括連携完了', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(
          '全${_matches.length}試合の日程および各チケット販売日を「$_selectedCalendar」に同期しました。\n\nキックオフ$_notifyKickoffHoursBefore時間前、チケット発売$_notifyTicketMinutesBefore分前にリマインダー通知が送信されます。',
          style: const TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('閉じる', style: TextStyle(color: AntlersTheme.primaryRed)),
          ),
        ],
      ),
    );
  }

  void _showMatchDetail(AntlersMatch match) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => MatchDetailModal(
        match: match,
        onToggleSync: () => _toggleCalendarSync(match),
        onStateChanged: () => setState(() {}),
        onOpenReview: () => _showReviewModal(match),
      ),
    );
  }

  void _showReviewModal(AntlersMatch match) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => MatchReviewModal(
        match: match,
        onSaved: () => setState(() {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      MatchScheduleScreen(
        matches: _matches,
        onToggleSync: _toggleCalendarSync,
        onShowDetail: _showMatchDetail,
        onSyncAll: _syncAllMatches,
      ),
      TicketTimelineScreen(
        matches: _matches,
        onShowDetail: _showMatchDetail,
      ),
      CalendarSettingsScreen(
        selectedCalendar: _selectedCalendar,
        autoSyncEnabled: _autoSyncEnabled,
        kickoffHours: _notifyKickoffHoursBefore,
        ticketMinutes: _notifyTicketMinutesBefore,
        totalSyncedMatches: _matches.where((m) => m.isCalendarSynced).length,
        totalSyncedTickets: _matches.fold(0, (acc, m) => acc + m.ticketPhases.where((p) => p.isCalendarSynced).length),
        onCalendarChanged: (val) => setState(() => _selectedCalendar = val),
        onAutoSyncChanged: (val) => setState(() => _autoSyncEnabled = val),
        onKickoffHoursChanged: (val) => setState(() => _notifyKickoffHoursBefore = val),
        onTicketMinutesChanged: (val) => setState(() => _notifyTicketMinutesBefore = val),
        onSyncAll: _syncAllMatches,
      ),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          selectedItemColor: AntlersTheme.primaryRed,
          unselectedItemColor: AntlersTheme.textMuted,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_soccer_outlined),
              activeIcon: Icon(Icons.sports_soccer),
              label: '試合日程',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_number_outlined),
              activeIcon: Icon(Icons.confirmation_number),
              label: 'チケット発売',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_available_outlined),
              activeIcon: Icon(Icons.event_available),
              label: '連携・通知設定',
            ),
          ],
        ),
      ),
    );
  }
}

class MatchScheduleScreen extends StatefulWidget {
  final List<AntlersMatch> matches;
  final Function(AntlersMatch) onToggleSync;
  final Function(AntlersMatch) onShowDetail;
  final VoidCallback onSyncAll;

  const MatchScheduleScreen({
    super.key,
    required this.matches,
    required this.onToggleSync,
    required this.onShowDetail,
    required this.onSyncAll,
  });

  @override
  State<MatchScheduleScreen> createState() => _MatchScheduleScreenState();
}

class _MatchScheduleScreenState extends State<MatchScheduleScreen> {
  String _filter = 'ALL'; // 'ALL', 'HOME', 'AWAY'

  @override
  Widget build(BuildContext context) {
    final filteredMatches = widget.matches.where((m) {
      if (_filter == 'HOME') return m.isHome;
      if (_filter == 'AWAY') return !m.isHome;
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AntlersTheme.primaryRed,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.shield, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'KASHIMA ANTLERS',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    color: AntlersTheme.accentGold,
                  ),
                ),
                Text(
                  '試合・チケット日程同期',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: '全日程を一括同期',
            icon: const Icon(Icons.sync),
            onPressed: widget.onSyncAll,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AntlersTheme.navyDark,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      _buildFilterChip('すべて', 'ALL'),
                      const SizedBox(width: 8),
                      _buildFilterChip('HOME (カシマ)', 'HOME'),
                      const SizedBox(width: 8),
                      _buildFilterChip('AWAY', 'AWAY'),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: widget.onSyncAll,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AntlersTheme.primaryRed,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  icon: const Icon(Icons.cloud_sync, size: 16),
                  label: const Text('全同期', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredMatches.length,
              itemBuilder: (context, index) {
                final match = filteredMatches[index];
                return MatchCard(
                  match: match,
                  onTap: () => widget.onShowDetail(match),
                  onToggleSync: () => widget.onToggleSync(match),
                  onOpenReview: () => (context.findAncestorStateOfType<_MainNavigationScreenState>())?._showReviewModal(match),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _filter == value;
    return GestureDetector(
      onTap: () => setState(() => _filter = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AntlersTheme.primaryRed : Colors.white12,
          borderRadius: BorderRadius.circular(16),
          border: Border.Border.all(
            color: isSelected ? AntlersTheme.accentGold : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  final AntlersMatch match;
  final VoidCallback onTap;
  final VoidCallback onToggleSync;
  final VoidCallback? onOpenReview;

  const MatchCard({
    super.key,
    required this.match,
    required this.onTap,
    required this.onToggleSync,
    this.onOpenReview,
  });

  String _formatDate(DateTime dt) {
    final weekdays = ['月', '火', '水', '木', '金', '土', '日'];
    return '${dt.month}/${dt.day}(${weekdays[dt.weekday - 1]}) ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysUntil = match.kickOff.difference(now).inDays;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: match.isCalendarSynced ? AntlersTheme.primaryRed.withOpacity(0.3) : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* 大会名 & ホーム/アウェイラベル */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: match.isHome ? AntlersTheme.primaryRed : AntlersTheme.navyDark,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          match.isHome ? 'HOME' : 'AWAY',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        match.competitionName,
                        style: const TextStyle(fontSize: 12, color: AntlersTheme.textMuted, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: daysUntil <= 5 ? Colors.orange.withOpacity(0.15) : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'あと$daysUntil日',
                      style: TextStyle(
                        fontSize: 11,
                        color: daysUntil <= 5 ? Colors.deepOrange : AntlersTheme.textMuted,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              /* 対戦カード情報 */
              Row(
                children: [
                  // アントラーズ側
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          '鹿島',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AntlersTheme.textMain),
                        ),
                        SizedBox(width: 8),
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: AntlersTheme.primaryRed,
                          child: Text('鹿', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  // VS / 日時
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'VS',
                      style: TextStyle(fontWeight: FontWeight.w900, color: AntlersTheme.textMuted, fontSize: 13),
                    ),
                  ),
                  // 相手側
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.blueGrey[800],
                          child: Text(
                            match.opponentShort.substring(0, 1),
                            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            match.opponent,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AntlersTheme.textMain),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              /* キックオフ＆スタジアム情報 */
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time_filled, size: 15, color: AntlersTheme.primaryRed),
                    const SizedBox(width: 6),
                    Text(
                      _formatDate(match.kickOff),
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.stadium, size: 15, color: AntlersTheme.navyDark),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        match.stadium,
                        style: const TextStyle(fontSize: 11, color: AntlersTheme.textMuted),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              /* 直近のチケット販売状況とカレンダー連携アクションボタン */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton.icon(
                    onPressed: onOpenReview,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AntlersTheme.primaryRed,
                      side: const BorderSide(color: AntlersTheme.primaryRed),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    icon: const Icon(Icons.rate_review_outlined, size: 14),
                    label: Text(
                      match.review != null ? '感想・SNS編集' : '観戦記録・SNS',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // カレンダー同期トグルボタン
                  InkWell(
                    onTap: onToggleSync,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: match.isCalendarSynced ? AntlersTheme.primaryRed : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            match.isCalendarSynced ? Icons.event_available : Icons.event_note,
                            size: 15,
                            color: match.isCalendarSynced ? Colors.white : AntlersTheme.textMain,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            match.isCalendarSynced ? 'カレンダー連携中' : 'カレンダーに追加',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: match.isCalendarSynced ? Colors.white : AntlersTheme.textMain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketStatusSnippet(AntlersMatch match) {
    if (match.ticketPhases.isEmpty) {
      return const Text('チケット情報なし', style: TextStyle(fontSize: 11, color: AntlersTheme.textMuted));
    }

    final now = DateTime.now();
    final upcomingPhase = match.ticketPhases.firstWhere(
      (p) => p.saleDate.isAfter(now),
      orElse: () => match.ticketPhases.last,
    );

    final isPast = upcomingPhase.saleDate.isBefore(now);

    return Row(
      children: [
        const Icon(Icons.confirmation_number, size: 14, color: AntlersTheme.accentGold),
        const SizedBox(width: 4),
        Text(
          isPast ? 'チケット販売中' : '${upcomingPhase.title}: ${upcomingPhase.saleDate.month}/${upcomingPhase.saleDate.day}発売',
          style: TextStyle(
            fontSize: 11,
            color: isPast ? Colors.green[700] : AntlersTheme.textMuted,
            fontWeight: isPast ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class TicketTimelineScreen extends StatelessWidget {
  final List<AntlersMatch> matches;
  final Function(AntlersMatch) onShowDetail;

  const TicketTimelineScreen({
    super.key,
    required this.matches,
    required this.onShowDetail,
  });

  @override
  Widget build(BuildContext context) {
    // 全チケットフェーズを日付順にソートしたリストを生成
    final List<Map<String, dynamic>> allPhases = [];
    for (var match in matches) {
      for (var phase in match.ticketPhases) {
        allPhases.add({
          'match': match,
          'phase': phase,
        });
      }
    }
    allPhases.sort((a, b) => (a['phase'] as TicketPhase).saleDate.compareTo((b['phase'] as TicketPhase).saleDate));

    return Scaffold(
      appBar: AppBar(
        title: const Text('チケット発売カレンダー', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            color: AntlersTheme.primaryRed.withOpacity(0.08),
            child: Row(
              children: const [
                Icon(Icons.info_outline, color: AntlersTheme.primaryRed, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'SÓCIO先行・ファンクラブ先行・一般発売の販売開始時刻にプッシュ通知とカレンダーリマインダーが届きます。',
                    style: TextStyle(fontSize: 11.5, color: AntlersTheme.navyDark, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: allPhases.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = allPhases[index];
                final match = item['match'] as AntlersMatch;
                final phase = item['phase'] as TicketPhase;
                final now = DateTime.now();
                final isPassed = phase.saleDate.isBefore(now);

                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: phase.isCalendarSynced ? AntlersTheme.primaryRed.withOpacity(0.3) : Colors.grey[200]!,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // 日時バッジ
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: isPassed ? Colors.grey[200] : AntlersTheme.navyDark,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '${phase.saleDate.month}/${phase.saleDate.day}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isPassed ? Colors.grey[600] : Colors.white,
                              ),
                            ),
                            Text(
                              '${phase.saleDate.hour.toString().padLeft(2, '0')}:${phase.saleDate.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                fontSize: 11,
                                color: isPassed ? Colors.grey[500] : AntlersTheme.accentGold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),
                      // チケット情報
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: phase.title.contains('SÓCIO')
                                        ? AntlersTheme.primaryRed
                                        : (phase.title.contains('ファンクラブ') ? AntlersTheme.navyDark : Colors.teal),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    phase.title,
                                    style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                if (isPassed)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text('受付中', style: TextStyle(fontSize: 9, color: Colors.black87)),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'vs ${match.opponent}（${match.isHome ? "ホーム" : "アウェイ"}）',
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '対象: ${phase.targetAudience}',
                              style: const TextStyle(fontSize: 11, color: AntlersTheme.textMuted),
                            ),
                          ],
                        ),
                      ),
                      // カレンダー通知ステータスアイコン
                      IconButton(
                        icon: Icon(
                          phase.isCalendarSynced ? Icons.notifications_active : Icons.notifications_none,
                          color: phase.isCalendarSynced ? AntlersTheme.primaryRed : Colors.grey,
                        ),
                        onPressed: () => onShowDetail(match),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarSettingsScreen extends StatelessWidget {
  final String selectedCalendar;
  final bool autoSyncEnabled;
  final int kickoffHours;
  final int ticketMinutes;
  final int totalSyncedMatches;
  final int totalSyncedTickets;
  final ValueChanged<String> onCalendarChanged;
  final ValueChanged<bool> onAutoSyncChanged;
  final ValueChanged<int> onKickoffHoursChanged;
  final ValueChanged<int> onTicketMinutesChanged;
  final VoidCallback onSyncAll;

  const CalendarSettingsScreen({
    super.key,
    required this.selectedCalendar,
    required this.autoSyncEnabled,
    required this.kickoffHours,
    required this.ticketMinutes,
    required this.totalSyncedMatches,
    required this.totalSyncedTickets,
    required this.onCalendarChanged,
    required this.onAutoSyncChanged,
    required this.onKickoffHoursChanged,
    required this.onTicketMinutesChanged,
    required this.onSyncAll,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('カレンダー連携・通知設定', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /* 同期ステータスカード */
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AntlersTheme.navyDark, Color(0xFF0A254D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '同期ステータス',
                      style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AntlersTheme.accentGold.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AntlersTheme.accentGold),
                      ),
                      child: const Text(
                        '常時同期中',
                        style: TextStyle(color: AntlersTheme.accentGold, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildStatItem('同期済み試合', '$totalSyncedMatches 試合'),
                    Container(width: 1, height: 35, color: Colors.white24),
                    _buildStatItem('チケット通知予定', '$totalSyncedTickets 件'),
                  ],
                ),
                const SizedBox(height: 14),
                ElevatedButton.icon(
                  onPressed: onSyncAll,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AntlersTheme.primaryRed,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('今すぐ全データを再同期する', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          /* 連携先カレンダー選択 */
          const Text('連携カレンダーアカウント', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AntlersTheme.textMain)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Apple カレンダー (鹿島公式)'),
                  subtitle: const Text('iOS標準カレンダーアプリと自動同期'),
                  value: 'Apple カレンダー (鹿島公式)',
                  groupValue: selectedCalendar,
                  activeColor: AntlersTheme.primaryRed,
                  onChanged: (val) {
                    if (val != null) onCalendarChanged(val);
                  },
                ),
                const Divider(height: 1),
                RadioListTile<String>(
                  title: const Text('Google カレンダー'),
                  subtitle: const Text('Googleアカウント連携カレンダーに登録'),
                  value: 'Google カレンダー',
                  groupValue: selectedCalendar,
                  activeColor: AntlersTheme.primaryRed,
                  onChanged: (val) {
                    if (val != null) onCalendarChanged(val);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          /* 通知設定セクション */
          const Text('リマインダー通知設定', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AntlersTheme.textMain)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('新規日程の自動同期'),
                  subtitle: const Text('ルヴァン杯・天皇杯の勝ち上がり時に自動追加'),
                  value: autoSyncEnabled,
                  activeColor: AntlersTheme.primaryRed,
                  onChanged: onAutoSyncChanged,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.sports_soccer, color: AntlersTheme.primaryRed),
                  title: const Text('試合キックオフ前通知'),
                  trailing: DropdownButton<int>(
                    value: kickoffHours,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('1時間前')),
                      DropdownMenuItem(value: 2, child: Text('2時間前')),
                      DropdownMenuItem(value: 24, child: Text('前日 (24時間前)')),
                    ],
                    onChanged: (val) {
                      if (val != null) onKickoffHoursChanged(val);
                    },
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.confirmation_number, color: AntlersTheme.accentGold),
                  title: const Text('チケット発売直前通知'),
                  trailing: DropdownButton<int>(
                    value: ticketMinutes,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(value: 15, child: Text('15分前')),
                      DropdownMenuItem(value: 30, child: Text('30分前')),
                      DropdownMenuItem(value: 60, child: Text('1時間前')),
                      DropdownMenuItem(value: 1440, child: Text('前日リマインド')),
                    ],
                    onChanged: (val) {
                      if (val != null) onTicketMinutesChanged(val);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          /* カレンダーURL連携 (iCal形式) */
          const Text('外部カレンダー購読用 URL (iCal)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AntlersTheme.textMain)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'webcal://calendar.antlers.co.jp/v1/schedule.ics',
                    style: TextStyle(fontSize: 12, color: AntlersTheme.textMuted, fontFamily: 'monospace'),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('iCal購読URLをクリップボードにコピーしました')),
                    );
                  },
                  child: const Text('コピー', style: TextStyle(color: AntlersTheme.primaryRed, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(color: Colors.white60, fontSize: 11)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class MatchDetailModal extends StatefulWidget {
  final AntlersMatch match;
  final VoidCallback onToggleSync;
  final VoidCallback onStateChanged;
  final VoidCallback onOpenReview;

  const MatchDetailModal({
    super.key,
    required this.match,
    required this.onToggleSync,
    required this.onStateChanged,
    required this.onOpenReview,
  });

  @override
  State<MatchDetailModal> createState() => _MatchDetailModalState();
}

class _MatchDetailModalState extends State<MatchDetailModal> {
  @override
  Widget build(BuildContext context) {
    final match = widget.match;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* ドラッグハンドル */
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              /* 試合ヘッダー */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: match.isHome ? AntlersTheme.primaryRed : AntlersTheme.navyDark,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      match.isHome ? 'ホームゲーム' : 'アウェイゲーム',
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      match.isFavorite ? Icons.star : Icons.star_border,
                      color: match.isFavorite ? AntlersTheme.accentGold : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        match.isFavorite = !match.isFavorite;
                      });
                      widget.onStateChanged();
                    },
                  ),
                ],
              ),

              const SizedBox(height: 8),
              Text(
                'vs ${match.opponent}',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AntlersTheme.textMain),
              ),
              Text(
                '${match.competitionName} | ${match.stadium}',
                style: const TextStyle(fontSize: 13, color: AntlersTheme.textMuted),
              ),

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),

              /* カレンダー登録トグルスイッチ */
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AntlersTheme.bgGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('試合日程をカレンダーに同期', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        Text('キックオフ情報・スタジアム住所を登録', style: TextStyle(color: AntlersTheme.textMuted, fontSize: 11)),
                      ],
                    ),
                    Switch(
                      value: match.isCalendarSynced,
                      activeColor: AntlersTheme.primaryRed,
                      onChanged: (val) {
                        widget.onToggleSync();
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              /* チケット販売フェーズ一覧 */
              const Text(
                'チケット販売スケジュール',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AntlersTheme.textMain),
              ),
              const SizedBox(height: 8),

              ...match.ticketPhases.map((phase) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            phase.title,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '発売日: ${phase.saleDate.year}/${phase.saleDate.month}/${phase.saleDate.day} ${phase.saleDate.hour}:${phase.saleDate.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(color: AntlersTheme.primaryRed, fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                          Text('対象: ${phase.targetAudience}', style: const TextStyle(color: AntlersTheme.textMuted, fontSize: 10)),
                        ],
                      ),
                      // チケット個別リマインダー連携
                      IconButton(
                        tooltip: 'この販売日のリマインダー切替',
                        icon: Icon(
                          phase.isCalendarSynced ? Icons.alarm_on : Icons.alarm_add,
                          color: phase.isCalendarSynced ? AntlersTheme.primaryRed : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            phase.isCalendarSynced = !phase.isCalendarSynced;
                          });
                          widget.onStateChanged();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${phase.title}のリマインダーを${phase.isCalendarSynced ? "登録" : "解除"}しました'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 16),
              /* 鹿チケ購入ボタン */
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('鹿チケ（Jリーグチケット公式）へ遷移します'),
                      backgroundColor: AntlersTheme.navyDark,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AntlersTheme.navyDark,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.open_in_new, size: 18, color: AntlersTheme.accentGold),
                label: const Text('「鹿チケ」公式サイトを開く', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              /* 観戦記録モーダル起動 */
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  widget.onOpenReview();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AntlersTheme.primaryRed,
                  side: const BorderSide(color: AntlersTheme.primaryRed),
                  minimumSize: const Size.fromHeight(44),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.rate_review, size: 18),
                label: const Text('この試合の感想・結果を記録してSNSにシェア', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MatchReviewModal extends StatefulWidget {
  final AntlersMatch match;
  final VoidCallback onSaved;

  const MatchReviewModal({
    super.key,
    required this.match,
    required this.onSaved,
  });

  @override
  State<MatchReviewModal> createState() => _MatchReviewModalState();
}

class _MatchReviewModalState extends State<MatchReviewModal> {
  late TextEditingController _kashimaScoreController;
  late TextEditingController _opponentScoreController;
  late TextEditingController _momController;
  late TextEditingController _commentController;
  String _watchStyle = '現地観戦 (カシマスタジアム)';
  int _rating = 5;

  @override
  void initState() {
    super.initState();
    final r = widget.match.review ?? MatchReview();
    _kashimaScoreController = TextEditingController(text: r.kashimaScore.toString());
    _opponentScoreController = TextEditingController(text: r.opponentScore.toString());
    _momController = TextEditingController(text: r.myMom);
    _commentController = TextEditingController(text: r.comment);
    _watchStyle = r.watchStyle;
    _rating = r.rating;
  }

  @override
  void dispose() {
    _kashimaScoreController.dispose();
    _opponentScoreController.dispose();
    _momController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _saveReview() {
    widget.match.review = MatchReview(
      kashimaScore: int.tryParse(_kashimaScoreController.text) ?? 0,
      opponentScore: int.tryParse(_opponentScoreController.text) ?? 0,
      watchStyle: _watchStyle,
      rating: _rating,
      myMom: _momController.text,
      comment: _commentController.text,
    );
    widget.onSaved();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('観戦ログを保存しました！'), backgroundColor: AntlersTheme.primaryRed),
    );
  }

  void _shareToSns(String platform) {
    final review = MatchReview(
      kashimaScore: int.tryParse(_kashimaScoreController.text) ?? 0,
      opponentScore: int.tryParse(_opponentScoreController.text) ?? 0,
      watchStyle: _watchStyle,
      rating: _rating,
      myMom: _momController.text,
      comment: _commentController.text,
    );
    final text = review.generateSnsPostText(widget.match);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$platformへの共有テキストを生成しました。\n(実機ではshare_plus/url_launcherが呼び出されます)'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
              ),
            ),
            Text('vs ${widget.match.opponent} 観戦ログ', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            /* スコア入力 */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text('鹿島', style: TextStyle(fontWeight: FontWeight.bold, color: AntlersTheme.primaryRed)),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        controller: _kashimaScoreController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('-', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey)),
                ),
                Column(
                  children: [
                    Text(widget.match.opponentShort, style: const TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        controller: _opponentScoreController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            /* マイMOM */
            TextField(
              controller: _momController,
              decoration: const InputDecoration(
                labelText: '本日のマイMOM (Man of the Match)',
                hintText: '例: 鈴木優磨、知念慶',
                isDense: true,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            /* 感想コメント */
            TextField(
              controller: _commentController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: '観戦の感想・スタグル・応援コメント',
                hintText: 'ゴール裏の熱気やもつ煮、応援の感想など...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            /* 保存 & SNSボタン */
            ElevatedButton(
              onPressed: _saveReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: AntlersTheme.primaryRed,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(44),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('観戦ログを保存', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _shareToSns('𝕏 (Twitter)'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('𝕏 でポスト', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _shareToSns('LINE'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF06C755),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('LINEで共有', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
