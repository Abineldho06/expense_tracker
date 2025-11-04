import 'package:expense_tracker/services/db_helper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  bool showExpense = true;
  final dbHelper = DatabaseHelper();

  double totalExpense = 0;
  double totalIncome = 0;
  List<double> expenseData = [2200, 3400, 3100, 3900, 4200, 3600, 4100];
  List<double> incomeData = [3000, 3700, 3900, 4200, 4600, 4800, 5000];

  List<String> months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL'];

  @override
  void initState() {
    super.initState();
    _loadAnalytics();
  }

  Future<void> _loadAnalytics() async {
    await dbHelper.initdb();

    num exp = await dbHelper.getTotalExpense();
    num inc = await dbHelper.getTotalIncome();

    setState(() {
      totalExpense = exp.toDouble();
      totalIncome = inc.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 2, 71, 88),
            Color.fromARGB(255, 0, 28, 42),
            Color.fromARGB(255, 1, 29, 55),
            Color.fromARGB(255, 9, 0, 18),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'statistics',
            style: GoogleFonts.inter(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: expenseData.isEmpty && incomeData.isEmpty
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Expense / Income Toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildToggleCard(
                            title: 'Expense',
                            amount: totalExpense,
                            isActive: showExpense,
                            color: Colors.redAccent,
                            onTap: () => setState(() => showExpense = true),
                          ),
                          _buildToggleCard(
                            title: 'Income',
                            amount: totalIncome,
                            isActive: !showExpense,
                            color: Colors.blueGrey.shade700,
                            onTap: () => setState(() => showExpense = false),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Chart
                      SizedBox(
                        height: 230,
                        child: LineChart(
                          mainData(
                            showExpense ? expenseData : incomeData,
                            showExpense ? Colors.redAccent : Colors.greenAccent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Month Labels
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: months
                            .map(
                              (m) => Text(
                                m,
                                style: GoogleFonts.inter(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 13,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 30),

                      // History Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'History',
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'See all',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      FutureBuilder(
                        future: showExpense
                            ? dbHelper.getExpensesWithCategory()
                            : dbHelper.getIncomes(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }
                          final data =
                              snapshot.data as List<Map<String, dynamic>>;
                          if (data.isEmpty) {
                            return Center(
                              child: Text(
                                'No records yet',
                                style: GoogleFonts.inter(color: Colors.white70),
                              ),
                            );
                          }
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              var item = data[index];
                              return _buildHistoryCard(
                                showExpense
                                    ? item['category_name'] ?? 'Unknown'
                                    : item['source'] ?? 'Income',
                                showExpense
                                    ? item['note'] ?? ''
                                    : DateFormat('dd MMM').format(
                                        DateTime.tryParse(item['date'] ?? '') ??
                                            DateTime.now(),
                                      ),
                                '-${item['amount'] ?? ''}',
                                showExpense
                                    ? Icons.shopping_bag
                                    : Icons.attach_money,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  // Toggle Card
  Widget _buildToggleCard({
    required String title,
    required double amount,
    required bool isActive,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 70,
        width: 150,
        decoration: BoxDecoration(
          color: isActive ? color : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
              ),
            ),
            Text(
              '\$${amount.toStringAsFixed(0)}',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Chart
  LineChartData mainData(List<double> data, Color color) {
    return LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: (data.length - 1).toDouble(),
      minY: 0,
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          spots: data
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), e.value))
              .toList(),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color.withOpacity(0.3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [color.withOpacity(0.3), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          dotData: const FlDotData(show: false),
          barWidth: 3,
        ),
      ],
    );
  }

  // History card
  Widget _buildHistoryCard(
    String title,
    String subtitle,
    String amount,
    IconData icon,
  ) {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade800,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.inter(
            color: Colors.white.withOpacity(0.6),
            fontSize: 13,
          ),
        ),
        trailing: Text(
          amount,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
