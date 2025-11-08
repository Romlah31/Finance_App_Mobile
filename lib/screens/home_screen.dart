import 'package:flutter/material.dart';
import '../widgets/atm_card.dart';
import '../widgets/transaction_item.dart';
import '../models/transaction.dart';
import '../widgets/grid_menu_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = "";
  String selectedCategory = "All";

  bool isDarkMode = false;

  final categories = ["All", "Health", "Travel", "Food", "Event"];

  final PageController _cardController = PageController(viewportFraction: 0.78);
  int currentCardIndex = 0;

  @override
  void initState() {
    super.initState();

    _cardController.addListener(() {
      setState(() {
        currentCardIndex = _cardController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode;

    final transactions = [
      TransactionModel('Coffee Shop', '-Rp35.000', 'Food'),
      TransactionModel('Grab Ride', '-Rp25.000', 'Travel'),
      TransactionModel('Gym Membership', '-Rp150.000', 'Health'),
      TransactionModel('Movie Ticket', '-Rp60.000', 'Event'),
      TransactionModel('Salary', '+Rp5.000.000', 'Income'),
    ];

    final filteredTransactions = transactions.where((t) {
      final matchesSearch =
          t.title.toLowerCase().contains(searchText.toLowerCase());
      final matchesCategory =
          selectedCategory == "All" || t.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? const Color.fromARGB(255, 117, 116, 116) : Colors.white,

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 158, 218),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          "assets/img/logo.png",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Hallo,",
                            style: TextStyle(color: Colors.deepPurple, fontSize: 14),
                          ),
                          Text(
                            "Romlah Hanafiah!",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  IconButton(
                    icon: Icon(
                      isDark ? Icons.light_mode : Icons.dark_mode,
                      color: Colors.deepPurple,
                    ),
                    onPressed: toggleTheme,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF8B4DFF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Balance",
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Rp31.850.000",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
            'My Cards',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 185, 143, 216), 
            ),
          ),


            const SizedBox(height: 12),

            SizedBox(
              height: 220,
              child: PageView.builder(
                controller: _cardController,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _cardController,
                    builder: (context, child) {
                      double value = 1.0;

                      if (_cardController.position.haveDimensions) {
                        value = (_cardController.page! - index).abs();
                        value = (1 - value * 0.3).clamp(0.7, 1.0);
                      }

                      return Center(
                        child: Transform.scale(
                          scale: value,
                          child: child,
                        ),
                      );
                    },
                    child: [
                      const AtmCard(
                        bankName: 'RHS Finance A',
                        cardNumber: '**** 2345',
                        balance: 'Rp12.500.000',
                        color1: Color(0xFF6A0DAD),
                        color2: Color(0xFF9B4DFF),
                        color3: Color(0xFFE46FD3),
                      ),
                      const AtmCard(
                        bankName: 'RHS Finance B',
                        cardNumber: '**** 8765',
                        balance: 'Rp5.350.000',
                        color1: Color(0xFFFF7FBF),
                        color2: Color(0xFFE46FF6),
                        color3: Color(0xFF9B4DFF),
                      ),
                      const AtmCard(
                        bankName: 'RHS Finance C',
                        cardNumber: '**** 7596',
                        balance: 'Rp4.000.000',
                        color1: Color(0xFF9B4DFF),
                        color2: Color(0xFFE46FD3),
                        color3: Color(0xFFFF7FBF),
                      ),
                      const AtmCard(
                        bankName: 'RHS Finance D',
                        cardNumber: '**** 3105',
                        balance: 'Rp10.000.000',
                        color1: Color(0xFFE46FD3),
                        color2: Color(0xFF9B4DFF),
                        color3: Color(0xFF9B4DFF),
                      ),
                    ][index],
                  );
                },
              ),
            ),

            const SizedBox(height: 10),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                bool isActive = currentCardIndex == index;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFF6A0DAD)
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            // ✅ GRID MENU
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                GridMenuItem(
                  icon: Icons.health_and_safety,
                  label: 'Health',
                  labelColor: Colors.white,
                  bgColor: const Color(0xFF9B4DFF),
                  iconColor: Colors.white,
                  onTap: () => _openCategory("Health"),
                ),
                GridMenuItem(
                  icon: Icons.travel_explore,
                  label: 'Travel',
                  labelColor: Colors.white,
                  bgColor: const Color(0xFFE46FD3),
                  iconColor: Colors.white,
                  onTap: () => _openCategory("Travel"),
                ),
                GridMenuItem(
                  icon: Icons.fastfood,
                  label: 'Food',
                  labelColor: Colors.white,
                  bgColor: const Color(0xFFFF7FBF),
                  iconColor: Colors.white,
                  onTap: () => _openCategory("Food"),
                ),
                GridMenuItem(
                  icon: Icons.event,
                  label: 'Event',
                  labelColor: Colors.white,
                  bgColor: const Color(0xFF6A0DAD),
                  iconColor: Colors.white,
                  onTap: () => _openCategory("Event"),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ✅ SEARCH BAR
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search transactions...",
                filled: true,
                fillColor: isDark ? const Color.fromARGB(255, 97, 96, 96) : Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => setState(() => searchText = value),
            ),

            const SizedBox(height: 16),

            // ✅ CATEGORY FILTER
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final isActive = categories[index] == selectedCategory;

                  return GestureDetector(
                    onTap: () =>
                        setState(() => selectedCategory = categories[index]),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFF6A0DAD)
                            : (isDark
                                ? Colors.grey.shade800
                                : Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: isActive
                              ? Colors.white
                              : (isDark ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Recent Transactions',
              style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 185, 143, 216), 
            ),
            ),

            const SizedBox(height: 8),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) =>
                  TransactionItem(transaction: filteredTransactions[index]),
            ),
          ],
        ),
      ),
    );
  }

  void _openCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryPage(category: category),
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String category;

  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        title: Text(category),
        backgroundColor: const Color(0xFF6A0DAD),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          "Page for $category",
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
