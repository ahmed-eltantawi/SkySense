import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  bool isLoading = false;
  late List<String> autoCompleteCities;
  String searchText = '';

  Future fetchAutoCompleteCities() async {
    setState(() {
      isLoading = true;
    });
    final String citiesData = await rootBundle.loadString('assets/cities.json');
    final Map<String, dynamic> json = jsonDecode(citiesData);

    final List cities = json['cities'];

    final List<String> jsonCitiesData = cities.cast<String>();
    setState(() {
      isLoading = false;
      autoCompleteCities = jsonCitiesData;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAutoCompleteCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Search City')),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsetsGeometry.all(10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Autocomplete(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<String>.empty();
                          } else {
                            return autoCompleteCities.where((word) => word
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()));
                          }
                        },
                        optionsViewBuilder:
                            (context, Function(String) onSelected, options) {
                          return Material(
                            elevation: 4,
                            child: ListView.separated(
                                padding: const EdgeInsets.all(8),
                                itemBuilder: (context, index) {
                                  final option = options.elementAt(index);
                                  return ListTile(
                                    title: SubstringHighlight(
                                      text: option.toString(),
                                      term: searchText,
                                      textStyle: TextStyle(
                                          fontSize: 23,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      textStyleHighlight: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 25,
                                        backgroundColor: const Color(0xFFFFF59D)
                                            .withOpacity(0.1),
                                      ),
                                    ),
                                    onTap: () {
                                      onSelected(option.toString());
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemCount: options.length),
                          );
                        },
                        onSelected: (selectedCity) async {
                          await submitSearching(context, selectedCity);
                        },
                        fieldViewBuilder: (context, controller, focusNode,
                            onEditingComplete) {
                          return TextField(
                            controller: controller,
                            focusNode: focusNode,
                            onEditingComplete: onEditingComplete,
                            onChanged: (value) {
                              setState(() {
                                searchText = value;
                              });
                            },
                            onSubmitted: (value) async {
                              await submitSearching(context, value);
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Your City',
                              hintStyle: const TextStyle(),
                              labelText: 'Search',
                              labelStyle: const TextStyle(),
                              suffixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.blue)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 2.5)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ));
  }

  Future<void> submitSearching(BuildContext context, String value) async {
    FocusScope.of(context).unfocus();
    var getWeatherCubit = BlocProvider.of<GetWeatherCubit>(context);
    await getWeatherCubit.getWeather(cityName: value);
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
