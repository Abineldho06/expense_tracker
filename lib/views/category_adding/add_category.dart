import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/services/db_helper.dart';
import 'package:expense_tracker/views/global_widgets/custom_button.dart';
import 'package:expense_tracker/views/global_widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ICON LIST
final List<IconData> iconList = [
  Icons.fastfood,
  Icons.shopping_cart,
  Icons.home,
  Icons.directions_car,
  Icons.attach_money,
  Icons.health_and_safety,
  Icons.movie,
  Icons.school,
  Icons.sports_soccer,
  Icons.pets,
];

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController catcontroller = TextEditingController();
  FocusNode focusNode = FocusNode();

  int? selectedIconIndex;

  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<void> _insertCategory() async {
    final name = catcontroller.text.trim();

    if (name.isEmpty || selectedIconIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter category name and select an icon"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final selectedIcon = iconList[selectedIconIndex!].codePoint.toString();

    final category = Category(name: name, icon: selectedIcon);

    // Insert into DB
    await dbHelper.insertCategory(category);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Category added successfully!"),
        backgroundColor: Colors.green,
      ),
    );

    catcontroller.clear();
    setState(() => selectedIconIndex = null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 2, 71, 88), // Deep violet at top
            Color.fromARGB(255, 0, 28, 42), // Rich indigo center
            Color.fromARGB(255, 1, 29, 55), // Rich indigo center
            Color.fromARGB(255, 9, 0, 18), // Subtle purple at bottom
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const BackButton(color: Colors.white),
          title: Text(
            'Add Category',
            style: GoogleFonts.inter(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: const [
            CircleAvatar(radius: 20, backgroundColor: Colors.white),
            SizedBox(width: 15),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add your Expense categories",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
                // Category name field
                textfield(
                  controller: catcontroller,
                  focusNode: focusNode,
                  labelText: 'Category',
                  validator: (_) {},
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 40),

                // ICON GRID
                Text(
                  "Select an Icon",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 20),
                GridView.builder(
                  itemCount: iconList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final isSelected = selectedIconIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIconIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white.withOpacity(0.8)
                              : Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                          border: isSelected
                              ? Border.all(color: Colors.amber, width: 2)
                              : null,
                        ),
                        child: Icon(
                          iconList[index],
                          color: isSelected ? Colors.black : Colors.white,
                          size: 30,
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),

                // Submit Button
                CustomButton(onPressed: _insertCategory, text: 'Submit'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
