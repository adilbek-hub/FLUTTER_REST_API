class Countries {
  const Countries({required this.name, required this.domain});
  final String name;
  final String domain;
}

const Countries oae = Countries(name: 'OAE', domain: 'ae');
const Countries argentina = Countries(name: 'Argentina', domain: 'ar');
const Countries france = Countries(name: 'France', domain: 'fr');
const Countries korea = Countries(name: 'Korea', domain: 'kr');
const Countries poland = Countries(name: 'Poland', domain: 'pl');
const Countries russia = Countries(name: 'Russia', domain: 'ru');
const Countries italy = Countries(name: 'Italy', domain: 'lt');

Set<Countries> countries = {
  oae,
  argentina,
  france,
  korea,
  poland,
  russia,
  italy,
};
