import 'package:flutter/material.dart';

void main() {
  runApp(const SignSafeApp());
}

class SignSafeApp extends StatelessWidget {
  const SignSafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SignSafe AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFF10B981),
      ),
      home: const HomeScreen(),
    );
  }
}

// -----------------------------------------------------------------------------
// 1. ANA EKRAN (HOME SCREEN)
// -----------------------------------------------------------------------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedJurisdiction = 'ABD - California';

  void _simulateScan(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          safetyScore: 35,
          jurisdiction: selectedJurisdiction,
          summary:
              'Bu sözleşmede kiracının aleyhine ağır maddeler ve yüksek tazminat yükümlülükleri tespit edilmiştir.',
          redFlags: const [
            '12. Madde: Ev sahibi önceden haber vermeksizin kirayı %200 artırabilir.',
            '18. Madde: Depozito iadesi 1 yıl sonra yapılacaktır.',
            '25. Madde: Kiracı sözleşmeyi erken feshederse tüm yılın kirasını öder.',
          ],
          recommendations:
              '12. Maddenin çıkarılmasını, depozito iade süresinin 14 güne düşürülmesini talep edin.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'SignSafe AI',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          DropdownButton<String>(
            value: selectedJurisdiction,
            dropdownColor: const Color(0xFF1E293B),
            style: const TextStyle(
                color: Color(0xFF10B981), fontWeight: FontWeight.w600),
            underline: const SizedBox(),
            items: <String>[
              'ABD - California',
              'ABD - New York',
              'Türkiye',
              'Almanya'
            ].map((String value) {
              return DropdownMenuItem<String>(
                  value: value, child: Text(value));
            }).toList(),
            onChanged: (newValue) {
              setState(() => selectedJurisdiction = newValue!);
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                    color: const Color(0xFF10B981).withOpacity(0.5), width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.document_scanner_rounded,
                      size: 64, color: Color(0xFF10B981)),
                  const SizedBox(height: 16),
                  const Text(
                    'Sözleşmenizi Tarayın veya Yükleyin',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Geçerli Hukuk: $selectedJurisdiction',
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () => _simulateScan(context),
                icon: const Icon(Icons.camera_alt, color: Colors.black),
                label: const Text(
                  'Sözleşme Fotoğrafı Çek / Tara',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                side: const BorderSide(color: Colors.white24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () => _simulateScan(context),
              icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
              label: const Text('PDF veya Doküman Yükle',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 2. SONUÇ VE RİSK RAPORU EKRANI (RESULT SCREEN)
// -----------------------------------------------------------------------------
class ResultScreen extends StatelessWidget {
  final int safetyScore;
  final String summary;
  final List<String> redFlags;
  final String recommendations;
  final String jurisdiction;

  const ResultScreen({
    super.key,
    required this.safetyScore,
    required this.summary,
    required this.redFlags,
    required this.recommendations,
    required this.jurisdiction,
  });

  @override
  Widget build(BuildContext context) {
    final isHighRisk = safetyScore < 60;
    final themeColor =
        isHighRisk ? const Color(0xFFEF4444) : const Color(0xFF10B981);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Risk Analiz Raporu',
            style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: themeColor, width: 2),
              ),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: CircularProgressIndicator(
                          value: safetyScore / 100,
                          strokeWidth: 8,
                          backgroundColor: Colors.white10,
                          color: themeColor,
                        ),
                      ),
                      Text(
                        '%$safetyScore',
                        style: TextStyle(
                            color: themeColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isHighRisk
                              ? 'YÜKSEK RİSK TESPİT EDİLDİ'
                              : 'GÜVENLİ SÖZLEŞME',
                          style: TextStyle(
                              color: themeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        const SizedBox(height: 4),
                        Text('Hukuk Alanı: $jurisdiction',
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Sözleşme Özeti',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16)),
              child: Text(summary,
                  style: const TextStyle(color: Colors.white70, height: 1.5)),
            ),
            const SizedBox(height: 24),
            const Text('🚨 Kırmızı Bayraklar (Kritik Riskler)',
                style: TextStyle(
                    color: Color(0xFFEF4444),
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...redFlags.map((flag) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: const Color(0xFFEF4444).withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded,
                          color: Color(0xFFEF4444)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: Text(flag,
                              style: const TextStyle(color: Colors.white))),
                    ],
                  ),
                )),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PaywallScreen()));
                },
                child: const Text('Sınırsız İnceleme İçin PRO\'ya Geç',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 3. ÖDEME VE ABONELİK EKRANI (PAYWALL SCREEN)
// -----------------------------------------------------------------------------
class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  int selectedPlan = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white54),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Sözleşmelerindeki Gizli Tuzaklara Son Ver',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Limitsiz AI taraması, eyalet bazlı risk analizi ve hukuki düzeltme önerilerine tam erişim kazan.',
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () => setState(() => selectedPlan = 1),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: selectedPlan == 1
                        ? const Color(0xFF10B981).withOpacity(0.15)
                        : const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: selectedPlan == 1
                            ? const Color(0xFF10B981)
                            : Colors.white10,
                        width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAlignment.start,
                        children: [
                          const Text('Yıllık Plan (%85 İndirim)',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('\$39.99 / Yıl (Haftalığı \$0.76)',
                              style: TextStyle(
                                  color: Colors.grey[400], fontSize: 13)),
                        ],
                      ),
                      Radio(
                          value: 1,
                          groupValue: selectedPlan,
                          activeColor: const Color(0xFF10B981),
                          onChanged: (val) =>
                              setState(() => selectedPlan = val as int)),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('3 Gün Ücretsiz Denemeyi Başlat',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
