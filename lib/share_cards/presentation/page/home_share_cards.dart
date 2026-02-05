import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:deck_share/share_cards/presentation/page/loan_creation_page.dart';
import 'package:deck_share/ui/atom/atom_card.dart';
import 'package:deck_share/ui/atom/atom_floating_action_button.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/molecules/molecule_slider_segmented_button.dart';
import 'package:deck_share/ui/organisms/organism_app_bar.dart';
import 'package:deck_share/ui/templates/template_base.dart';
import 'package:deck_share/ui/templates/template_loan_list.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Page to create a share cards
///

final lentNumber = StateProvider<int>((ref) => 0);
final borrowNumber = StateProvider<int>((ref) => 0);

class ShareCardsPage extends ConsumerStatefulWidget {
  const ShareCardsPage({super.key});

  @override
  ConsumerState<ShareCardsPage> createState() => _ShareCardsPageState();
}

class _ShareCardsPageState extends ConsumerState<ShareCardsPage> {
  @override
  void initState() {
    super.initState();
    // Chargement initial des données
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final controller = ref.read(shareCardsControllerProvider.notifier);

    // Charger les compteurs
    final lent = await controller.getNumberOfLent();
    final borrow = await controller.getNumberOfBorrow();

    ref.read(lentNumber.notifier).state = lent;
    ref.read(borrowNumber.notifier).state = borrow;

    // Charger la liste selon l'index actuel
    final currentIndex = ref.read(indexProvider);
    if (currentIndex == 0) {
      await controller.getLentCards();
    } else {
      await controller.getBorrowedCards();
    }
  }

  Future<void> _onIndexChanged(int index) async {
    _loadData();
  }

  Future<void> _fetchData() async {
    final controller = ref.read(shareCardsControllerProvider.notifier);
    final lent = await controller.getNumberOfLent();
    final borrow = await controller.getNumberOfBorrow();

    ref.read(lentNumber.notifier).state = lent;
    ref.read(borrowNumber.notifier).state = borrow;
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<ShareCards>> state = ref.watch(
      shareCardsControllerProvider,
    );

    // Écouter les changements d'index pour recharger les données
    ref.listen<int>(indexProvider, (previous, next) {
      if (previous != next) {
        _onIndexChanged(next);
      }
    });

    ref.listen(shareCardsControllerProvider, (previous, next) {
      if (next is AsyncData) {
        _fetchData();
      }
    });

    return BaseTemplate(
      baseAppBar: BaseAppBar(title: 'Mes Prêts'),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                /*2 container avec icons de prêt et icon de d'emprunt*/
                Expanded(
                  child: BaseCard(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 15),
                        Icon(
                          Icons.volunteer_activism,
                          size: 50,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 10),
                        BaseText(
                          data: "Prêts actifs : ${ref.watch(lentNumber)}",
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: BaseCard(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 15),
                        Icon(
                          Icons.front_hand,
                          size: 50,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 10),
                        BaseText(
                          data: "Emprunts actifs : ${ref.watch(borrowNumber)}",
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            BaseSliderSegmentedButton(),
            SizedBox(height: 10),
            LoanList(
              loanList: ref.watch(shareCardsControllerProvider).value != null
                  ? ref.watch(shareCardsControllerProvider).value!
                  : [],
              filter: ref.watch(indexProvider) == 1
                  ? LoanListFilter.borrow
                  : LoanListFilter.lent,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: BaseFloatingActionButton(
        child: Icon(Icons.add, color: AppColors.textPrimary),
        onPressed: () async {
          ShareCards? sc = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoanCreationPage(),
              //ShareCardsCreationPage(pickCards: [], amILender: true),
            ),
          );
          if (sc != null) {
            await ref
                .read(shareCardsControllerProvider.notifier)
                .addShareCards(sc);
          }
          // Recharger les données après l'ajout
          await _loadData();
        },
      ),
    );
  }
}
