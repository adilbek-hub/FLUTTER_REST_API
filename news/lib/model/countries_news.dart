class Country {
  const Country({required this.name, required this.domain});
  final String name;
  final String domain;
}

const Country oae = Country(name: 'OAE', domain: 'ae');
const Country poland = Country(name: 'Poland', domain: 'pl');

const Set<Country> countries = {
  oae,
  poland,
};
