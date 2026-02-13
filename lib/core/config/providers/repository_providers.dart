
import 'package:deck_share/core/config/repository_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final repositoryTypeProvider = StateProvider<RepositoryType>((ref) => RepositoryType.firebase);
