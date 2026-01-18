import 'package:flutter/material.dart';
import 'package:pocketfind/widgets/hidden_gem_cart.dart';
import 'package:pocketfind/widgets/product_card.dart';
import 'package:pocketfind/widgets/category_chip.dart';
import 'package:pocketfind/core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'icon': '🍔', 'label': 'Food'},
    {'icon': '👕', 'label': 'Clothes'},
    {'icon': '🛒', 'label': 'Groceries'},
    {'icon': '🏠', 'label': 'Household'},
    {'icon': '🔌', 'label': 'Electronics'},
    {'icon': '📚', 'label': 'Books'},
    {'icon': '💊', 'label': 'Medicine'},
    {'icon': '🎮', 'label': 'Games'},
  ];

  final List<Map<String, dynamic>> hiddenGems = const [
    {
      'name': 'Jhampat',
      'price': 100,
      'shop': 'Local Stall',
      'distance': 250,
      'badge': 'Must try',
    },
    {
      'name': 'Momos',
      'price': 60,
      'shop': 'Street Corner',
      'distance': 180,
      'badge': 'Local favorite',
    },
    {
      'name': 'Chai',
      'price': 10,
      'shop': 'Tea Stall',
      'distance': 120,
      'badge': 'Cheap',
    },
  ];

  final List<Map<String, dynamic>> nearbyDeals = const [
    {
      'name': 'Rice 1kg',
      'price': 45,
      'shop': 'Local Kirana',
      'distance': 300,
      'originalPrice': 55,
    },
    {
      'name': 'Eggs (6)',
      'price': 36,
      'shop': 'Poultry Shop',
      'distance': 450,
      'originalPrice': 40,
    },
    {
      'name': 'Bread',
      'price': 25,
      'shop': 'Bakery',
      'distance': 200,
      'originalPrice': 30,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            backgroundColor: Colors.white,
            elevation: 0,
            expandedHeight: 160, // 👈 more space
            // Compact pinned title (shown when collapsed)
            title: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 18,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Koramangala, Bangalore',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                ),
              ],
            ),

            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 56, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Greeting
                      Text(
                        'Good morning 👋',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textLightColor,
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Search Bar
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search, color: Colors.grey),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'What are you looking for?',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categories
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return CategoryChip(
                          icon: category['icon']!,
                          label: category['label']!,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Hidden Gems
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '🔥 Hidden gems near you',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('See all'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: [
                      HiddenGemsCard(hiddenGems: hiddenGems),
                      ],
                  ),
                  const SizedBox(height: 24),
                  // Nearby Deals
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '📍 Nearby deals',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('See all'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final deal = nearbyDeals[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                child: ProductCard(
                  name: deal['name']!,
                  price: deal['price']!,
                  shop: deal['shop']!,
                  distance: deal['distance']!,
                  originalPrice: deal['originalPrice'],
                ),
              );
            }, childCount: nearbyDeals.length),
          ),
        ],
      ),
    );
  }
}
