import 'package:animation_app/background_painter.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _backgroundController;
  late final AnimationController _cardController;
  late final AnimationController _fabController;
  late final AnimationController _menuController;
  late final AnimationController _titleController;
  late final AnimationController _searchController;
  late final AnimationController _sectionController;
  late final AnimationController _statsController;

  final List<AnimationController> _itemControllers = [];
  final _scrollController = ScrollController();
  bool _isExpanded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _searchController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _sectionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _statsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    Future.delayed(Duration(milliseconds: 200), () {
      _searchController.forward();
    });
    Future.delayed(Duration(milliseconds: 400), () {
      _sectionController.forward();
    });
    Future.delayed(Duration(milliseconds: 800), () {
      _statsController.forward();
    });

    for (int i = 0; i < 3; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      );

      _itemControllers.add(controller);

      Future.delayed(Duration(milliseconds: 500 + (i * 100)), () {
        controller.forward();
      });

      _scrollController.addListener(() {
        final offset = _scrollController.offset;
        final maxOffset = _scrollController.position.maxScrollExtent;

        if (offset > maxOffset * 0.15 && !_fabController.isCompleted) {
          _fabController.forward();
        } else if (offset <= maxOffset * 0.15 && _fabController.isCompleted) {
          _fabController.reverse();
        }
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _backgroundController.dispose();
    _cardController.dispose();
    _fabController.dispose();
    _menuController.dispose();
    _titleController.dispose();
    _searchController.dispose();
    _sectionController.dispose();
    _statsController.dispose();
    for (final controller in _itemControllers) {
      controller.dispose();
    }
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _menuController.forward();
      } else {
        _menuController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _backgroundController,
            builder: (context, child) {
              return CustomPaint(
                size: Size(size.width, size.height),
                painter: BackgroundPainter(
                  animation: _backgroundController.value,
                  color1: theme.colorScheme.primary.withOpacity(0.3),
                  color2: theme.colorScheme.secondary.withOpacity(0.2),
                  color3: theme.colorScheme.tertiary.withOpacity(0.2),
                ),
              );
            },
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(16),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedBuilder(
                              animation: _titleController,
                              builder: (context, child) {
                                return Opacity(
                                  opacity: _titleController.value,
                                  child: Transform.translate(
                                    offset: Offset(
                                      0,
                                      20 * (1 - _titleController.value),
                                    ),
                                    child: Text(
                                      'Selamat Datang',
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: theme
                                                .colorScheme
                                                .onBackground
                                                .withOpacity(0.6),
                                          ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 4),
                            AnimatedBuilder(
                              animation: _titleController,
                              builder: (context, child) {
                                return Opacity(
                                  opacity: _titleController.value,
                                  child: Transform.translate(
                                    offset: Offset(
                                      0,
                                      20 * (1 - _titleController.value),
                                    ),
                                    child: Text(
                                      'Andika Febriansyah',
                                      style: theme.textTheme.headlineMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                theme.colorScheme.onBackground,
                                          ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _searchController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _searchController.value,
                            child: Transform.translate(
                              offset: Offset(
                                0,
                                20 * (1 - _searchController.value),
                              ),
                              child: Container(
                                height: 55,
                                margin: EdgeInsets.only(bottom: 24),
                                decoration: BoxDecoration(
                                  color: theme.cardColor,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search for Something',
                                    hintStyle: theme.textTheme.bodyMedium
                                        ?.copyWith(
                                          color: theme.colorScheme.onSurface
                                              .withOpacity(0.5),
                                        ),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: theme.colorScheme.primary,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      ...List.generate(
                        _itemControllers.length,
                        (index) => AnimatedBuilder(
                          animation: _itemControllers[index],
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                0,
                                20 * 1 - _itemControllers[index].value,
                              ),
                              child: Opacity(
                                opacity: _itemControllers[index].value,
                                child: Transform.translate(
                                  offset: Offset(
                                    0,
                                    20 * (1 - _itemControllers[index].value),
                                  ),
                                  child: Opacity(
                                    opacity: _itemControllers[index].value,
                                    child: _buildTaskCard(
                                      context,
                                      index,
                                      theme,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, int index, ThemeData theme) {
    final titles = ['Rapat Tim Desain', 'Review Kode', 'Update Proyek'];

    final times = ['10:00 AM', '2:00 PM', '4:00 PM'];

    final colors = [
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      theme.colorScheme.tertiary,
    ];

    final icons = [Icons.group, Icons.code, Icons.update];

    final isCompleted = index < 2;

    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: colors[index].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icons[index], color: colors[index], size: 24),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titles[index],
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          times[index],
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Icon(
                    isCompleted ? Icons.check_circle : Icons.circle,
                    color:
                        isCompleted
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface.withOpacity(0.2),
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
