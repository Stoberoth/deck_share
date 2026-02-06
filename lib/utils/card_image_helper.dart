
import 'package:scryfall_api/scryfall_api.dart';

String getCardImageUrl(MtgCard card)
{
  if (card.cardFaces!= null && card.cardFaces!.isNotEmpty)
  {
    return card.cardFaces![0].imageUris!.normal.toString();
  }
  return card.imageUris!.normal.toString();
}