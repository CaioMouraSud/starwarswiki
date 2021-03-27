import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/pages/characters/character_details/character_details_page.dart';
import 'package:starwarswiki/app/pages/characters/characters_controller.dart';
import 'package:starwarswiki/app/pages/characters/characters_page.dart';
import 'package:starwarswiki/app/pages/films/film_details/film_details_page.dart';
import 'package:starwarswiki/app/pages/films/films_controller.dart';
import 'package:starwarswiki/app/pages/films/films_page.dart';
import 'package:starwarswiki/app/pages/home/components/character_card_widget.dart';
import 'package:starwarswiki/app/pages/planets/planet_details/planet_details_page.dart';
import 'package:starwarswiki/app/pages/planets/planets_controller.dart';
import 'package:starwarswiki/app/pages/planets/planets_page.dart';
import 'package:starwarswiki/app/pages/species/specie_details/specie_details_page.dart';
import 'package:starwarswiki/app/pages/species/species_controller.dart';
import 'package:starwarswiki/app/pages/species/species_page.dart';
import 'package:starwarswiki/app/pages/starships/starship_details/starship_details_page.dart';
import 'package:starwarswiki/app/pages/starships/starships_controller.dart';
import 'package:starwarswiki/app/pages/starships/starships_page.dart';
import 'package:starwarswiki/app/pages/vehicles/vehicle_details/vehicle_details_page.dart';
import 'package:starwarswiki/app/pages/vehicles/vehicles_controller.dart';
import 'package:starwarswiki/app/pages/vehicles/vehicles_page.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import 'components/film_card_widget.dart';
import 'components/planet_card_widget.dart';
import 'components/specie_card_widget.dart';
import 'components/starship_card_widget.dart';
import 'components/vehicle_card_widget.dart';
import 'home_controller.dart';

final _homeController = Modular.get<HomeController>();
final _filmsController = Modular.get<FilmsController>();
final _charactersController = Modular.get<CharactersController>();
final _planetsController = Modular.get<PlanetsController>();
final _speciesController = Modular.get<SpeciesController>();
final _starshipsController = Modular.get<StarshipsController>();
final _vehiclesController = Modular.get<VehiclesController>();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _homeController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    _homeController
        .setScrollPosition(_homeController.scrollController.position.pixels);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints dimens) {
            return Row(
              children: [
                Container(
                  height: double.infinity,
                  width: dimens.maxWidth,
                  child: Observer(builder: (_) {
                    return NestedScrollView(
                        controller: _homeController.scrollController,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        body: Scrollbar(
                          child: CustomScrollView(
                            slivers: [
                              _sliverHorizontalList(
                                  title: 'Films',
                                  height: 280.0,
                                  width: 170.0,
                                  rows: 1,
                                  cards: _filmsController.films,
                                  card: (index) {
                                    return FilmCardWidget(
                                      film: _filmsController.films[index],
                                      onTap: () {
                                        MediaQuery.of(context).size.width > md
                                            ? _openCardDialog(
                                                dimens: dimens,
                                                item: FilmDetailsPage(
                                                    film: _filmsController
                                                        .films[index],
                                                    backButton: 2))
                                            : Navigator.push(context,
                                                CupertinoPageRoute(
                                                    builder: (context) {
                                                return FilmDetailsPage(
                                                    film: _filmsController
                                                        .films[index],
                                                    backButton: 1);
                                              }));
                                      },
                                    );
                                  },
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) {
                                              return FilmsPage();
                                            },
                                            fullscreenDialog: true));
                                  }),
                              SliverToBoxAdapter(child: SizedBox(height: 24.0)),
                              _sliverHorizontalList(
                                  title: 'Characters',
                                  height: 180.0,
                                  width: 140.0,
                                  rows: 1,
                                  cards: _charactersController.people,
                                  card: (index) {
                                    return CharacterCardWidget(
                                      character:
                                          _charactersController.people[index],
                                      onIconPressed: (id) => setState(() =>
                                          _charactersController.setFavorite(
                                              _charactersController
                                                  .people[index].id)),
                                      onTap: () {
                                        MediaQuery.of(context).size.width > md
                                            ? _openCardDialog(
                                                dimens: dimens,
                                                item: CharacterDetailsPage(
                                                    character:
                                                        _charactersController
                                                            .people[index],
                                                    backButton: 2),
                                              )
                                            : Navigator.push(context,
                                                CupertinoPageRoute(
                                                    builder: (context) {
                                                return CharacterDetailsPage(
                                                    character:
                                                        _charactersController
                                                            .people[index],
                                                    backButton: 1);
                                              }));
                                      },
                                    );
                                  },
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) {
                                              return CharactersPage();
                                            },
                                            fullscreenDialog: true));
                                  }),
                              SliverToBoxAdapter(child: SizedBox(height: 24.0)),
                              _sliverHorizontalList(
                                  title: 'Planets',
                                  height: 100.0 * 2,
                                  width: 100.0 * 2,
                                  rows: 2,
                                  cards: _planetsController.planets,
                                  card: (index) {
                                    return Observer(builder: (_) {
                                      return PlanetCardWidget(
                                        planet:
                                            _planetsController.planets[index],
                                        onTap: () {
                                          MediaQuery.of(context).size.width > md
                                              ? _openCardDialog(
                                                  dimens: dimens,
                                                  item: PlanetDetailsPage(
                                                      planet: _planetsController
                                                          .planets[index],
                                                      backButton: 2),
                                                )
                                              : Navigator.push(context,
                                                  CupertinoPageRoute(
                                                      builder: (context) {
                                                  return PlanetDetailsPage(
                                                      planet: _planetsController
                                                          .planets[index],
                                                      backButton: 1);
                                                }));
                                        },
                                      );
                                    });
                                  },
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) {
                                              return PlanetsPage();
                                            },
                                            fullscreenDialog: true));
                                  }),
                              SliverToBoxAdapter(child: SizedBox(height: 24.0)),
                              _sliverHorizontalList(
                                  title: 'Species',
                                  height: 80.0 * 2,
                                  width: 140.0 * 2,
                                  rows: 2,
                                  cards: _speciesController.species,
                                  card: (index) {
                                    return SpecieCardWidget(
                                      specie: _speciesController.species[index],
                                      onTap: () {
                                        MediaQuery.of(context).size.width > md
                                            ? _openCardDialog(
                                                dimens: dimens,
                                                item: SpecieDetailsPage(
                                                    specie: _speciesController
                                                        .species[index],
                                                    backButton: 2),
                                              )
                                            : Navigator.push(context,
                                                CupertinoPageRoute(
                                                    builder: (context) {
                                                return SpecieDetailsPage(
                                                    specie: _speciesController
                                                        .species[index],
                                                    backButton: 1);
                                              }));
                                      },
                                    );
                                  },
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) {
                                              return SpeciesPage();
                                            },
                                            fullscreenDialog: true));
                                  }),
                              SliverToBoxAdapter(child: SizedBox(height: 24.0)),
                              _sliverHorizontalList(
                                  title: 'Starships',
                                  height: 80.0 * 2,
                                  width: 140.0 * 2,
                                  rows: 2,
                                  cards: _starshipsController.starships,
                                  card: (index) {
                                    return StarshipCardWidget(
                                      starship:
                                          _starshipsController.starships[index],
                                      onTap: () {
                                        MediaQuery.of(context).size.width > md
                                            ? _openCardDialog(
                                                dimens: dimens,
                                                item: StarshipDetailsPage(
                                                    starship:
                                                        _starshipsController
                                                            .starships[index],
                                                    backButton: 2),
                                              )
                                            : Navigator.push(context,
                                                CupertinoPageRoute(
                                                    builder: (context) {
                                                return StarshipDetailsPage(
                                                    starship:
                                                        _starshipsController
                                                            .starships[index],
                                                    backButton: 1);
                                              }));
                                      },
                                    );
                                  },
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) {
                                              return StarshipsPage();
                                            },
                                            fullscreenDialog: true));
                                  }),
                              SliverToBoxAdapter(child: SizedBox(height: 24.0)),
                              _sliverHorizontalList(
                                  title: 'Vehicles',
                                  height: 100.0 * 3,
                                  width: 100.0 * 3,
                                  rows: 3,
                                  cards: _vehiclesController.vehicles,
                                  card: (index) {
                                    return VehicleCardWidget(
                                      vehicle:
                                          _vehiclesController.vehicles[index],
                                      onTap: () {
                                        MediaQuery.of(context).size.width > md
                                            ? _openCardDialog(
                                                dimens: dimens,
                                                item: VehicleDetailsPage(
                                                    vehicle: _vehiclesController
                                                        .vehicles[index],
                                                    backButton: 2),
                                              )
                                            : Navigator.push(context,
                                                CupertinoPageRoute(
                                                    builder: (context) {
                                                return VehicleDetailsPage(
                                                    vehicle: _vehiclesController
                                                        .vehicles[index],
                                                    backButton: 1);
                                              }));
                                      },
                                    );
                                  },
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) {
                                              return VehiclesPage();
                                            },
                                            fullscreenDialog: true));
                                  }),
                              SliverToBoxAdapter(child: SizedBox(height: 52.0))
                            ],
                          ),
                        ),
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            _sliverAppBar(),
                          ];
                        });
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _openCardDialog({required BoxConstraints dimens, required Widget item}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(6.0)),
            backgroundColor: Theme.of(context).bottomAppBarColor,
            content: ConstrainedBox(
              constraints: BoxConstraints(minWidth: dimens.maxWidth / 1.5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: item,
              ),
            ));
      },
    );
  }

  _sliverHorizontalList(
      {required String title,
      required double height,
      required double width,
      required List cards,
      required Function(int) card,
      required int rows,
      required Function onTap}) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(fontSize: 18)),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text('See all',
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).accentColor)),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      onTap();
                    },
                  ),
                ),
              ],
            ),
          ),
          if (rows > 1)
            Container(
                height: height,
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(width: width, child: card(index));
                  },
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: rows / 4,
                    maxCrossAxisExtent: height / rows,
                    mainAxisExtent: (width / rows) - 0.10,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0,
                  ),
                  itemCount: cards.length,
                )),
          if (rows == 1)
            Container(
              height: height,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 14.0),
                scrollDirection: Axis.horizontal,
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return Container(width: width, child: card(index));
                },
              ),
            ),
        ],
      ),
    );
  }

  _sliverAppBar() {
    return Observer(builder: (_) {
      return CupertinoSliverNavigationBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        largeTitle: Text('StarWars Wiki',
            style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black87
                    : Colors.yellow[600])),
        leading: CupertinoButton(
          minSize: 34,
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(50.0),
          child: Icon(CupertinoIcons.person_crop_circle_fill, size: 26),
          onPressed: () {},
        ),
        border: _homeController.scrollPosition >
                142.0 + MediaQuery.of(context).viewPadding.top
            ? Border(bottom: BorderSide(width: 0, color: Colors.black26))
            : Border.all(color: Colors.transparent),
      );
    });
  }
}
