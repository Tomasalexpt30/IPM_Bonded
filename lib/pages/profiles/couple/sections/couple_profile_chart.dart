import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CoupleProfileChart extends StatelessWidget {
  const CoupleProfileChart({
    super.key,
    required this.bondWeeks,
    required this.energyWeeks,
    required this.moodWeeks,
  });

  final List<List<double>> bondWeeks;
  final List<List<double>> energyWeeks;
  final List<List<double>> moodWeeks;

  @override
  Widget build(BuildContext context) {
    // EXATAMENTE 5 DIAS
    final days = ["21/11", "22/11", "23/11", "24/11", "25/11"];

    // EXATAMENTE 5 valores em cada linha
    final bond = [0.26, 0.44, 0.40, 0.68, 0.83];
    final energy = [0.58, 0.45, 0.62, 0.59, 0.57];
    final mood = [0.72, 0.75, 0.23, 0.77, 0.69];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildLegend(),
          const SizedBox(height: 14),

          SizedBox(
            height: 220,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  verticalInterval: 1,
                  getDrawingVerticalLine: (_) => FlLine(
                    color: Colors.grey.shade300.withOpacity(0.4),
                    strokeWidth: 1,
                  ),

                  // 👉 SOMENTE 5 TRAÇOS: 0, 0.25, 0.50, 0.75, 1.00
                  horizontalInterval: 0.25,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.shade300,
                      strokeWidth: 1,
                    );
                  },
                ),

                borderData: FlBorderData(show: false),

                titlesData: FlTitlesData(
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

                  // LEFT (0–100%)
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 0.25,
                      reservedSize: 30,
                      getTitlesWidget: (value, _) => Text(
                        "${(value * 100).round()}%",
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 11,
                          fontWeight: FontWeight.w600, // ← mais peso
                        ),
                      ),
                    ),
                  ),

                  // BOTTOM (5 dias)
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value < 0 || value > 4) return const SizedBox.shrink();

                        return Padding(
                          padding: const EdgeInsets.only(top: 10), // ← MAIOR ESPAÇAMENTO
                          child: Text(
                            days[value.toInt()],
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 11,
                              fontWeight: FontWeight.w600, // ← mais peso
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                ),

                minX: -0.2,
                maxX: 4.2,
                minY: 0,
                maxY: 1,


                lineBarsData: [
                  _lineData(bond, const Color(0xFF66C85B)),
                  _lineData(energy, const Color(0xFFFFB834)),
                  _lineData(mood, const Color(0xFFE085B5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // LEGEND
  // ------------------------------------------------------------
  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem("Connection", const Color(0xFF66C85B)),
        const SizedBox(width: 18),
        _legendItem("Energy", const Color(0xFFFFB834)),
        const SizedBox(width: 18),
        _legendItem("Affection", const Color(0xFFE085B5)),
      ],
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 4,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500, // ← mais pesado
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // LINE STYLE (PONTAS AFIADAS)
  // ------------------------------------------------------------
  LineChartBarData _lineData(List<double> values, Color color) {
    return LineChartBarData(
      isCurved: false, // << LINHA RETA, PONTAS AGUDAS
      barWidth: 3,
      color: color,

      dotData: FlDotData(show: false), // sem pontos

      belowBarData: BarAreaData(show: false),

      // Criar 5 spots
      spots: List.generate(values.length, (i) => FlSpot(i.toDouble(), values[i])),
    );
  }
}
