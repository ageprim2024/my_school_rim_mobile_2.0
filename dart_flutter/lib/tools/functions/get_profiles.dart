import '../constants/expression.dart';

getProfiles(String profiles) {
  List<Map> listProfiles = [];
  //CRS
  if (profiles.contains(typeCRS)) {
    listProfiles.add({
      keyProfile: typeCRS,
      keyPage: rootPageCorrespondant,
    });
  }
  //FRS
  if (profiles.contains(typeFRS)) {
    listProfiles.add({
      keyProfile: typeFRS,
      keyPage: rootPageFournisseur,
    });
  }
  //ENS
  if (profiles.contains(typeENS)) {
    listProfiles.add({
      keyProfile:typeENS,
      keyPage: rootPageEnseignant,
    });
  }
 //CNG
  if (profiles.contains(typeCNG)) {
    listProfiles.add({
      keyProfile:typeCNG,
      keyPage: rootPageControlleur,
    });
  }
  //CMP
  if (profiles.contains(typeCMP)) {
    listProfiles.add({
      keyProfile:typeCMP,
      keyPage: rootPageComptable,
    });
  }
  return listProfiles;
}
