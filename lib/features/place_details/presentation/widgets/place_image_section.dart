import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_zone/utils/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../domain/entities/branch_photo.dart';
import '../cubit/place_details_cubit.dart';
import '../cubit/place_details_state.dart';

class PlaceImageSection extends StatelessWidget {
  final int branchId;
  final dynamic placeDetails;
  final List<BranchPhotoEntity> photos;

  const PlaceImageSection({
    super.key,
    required this.branchId,
    this.placeDetails,
    required this.photos,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceDetailsCubit, PlaceDetailsState>(
      builder: (context, state) {
        if (state is PlaceDetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PlaceDetailsLoaded) {
          final branch = state.branchEntity;
          final photo = photos.isNotEmpty ? photos.first.photoUrl : null;

          return Stack(
            children: [
              photo != null
                  ? Image.network(
                photo,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey,
                    child:  Center(child: Text(AppLocalizations.of(context).failedToLoadImage)),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              )
                  : Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey,
                child:  Center(child: Text(AppLocalizations.of(context).noImage)),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(branch.placeName),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoRow(
                              icon: Icons.location_on,
                              label: AppLocalizations.of(context).address,
                              value: branch.address,
                              onCopy: () => _copyToClipboard(context, branch.address),
                            ),
                            const Divider(),
                            _infoRow(
                              icon: Icons.phone,
                              label: AppLocalizations.of(context).phone,
                              value: branch.phone,
                              onCopy: () => _copyToClipboard(context, branch.phone),
                            ),
                            const Divider(),
                            _infoRow(
                              icon: Icons.language,
                              label: AppLocalizations.of(context).website,
                              value: branch.website,
                              onCopy: () => _copyToClipboard(context, branch.website),
                              onOpen: () => _launchUrl(branch.website),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(AppLocalizations.of(context).close),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children:  [
                        Icon(Icons.info_outline, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context).details,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onCopy,
    VoidCallback? onOpen,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.teal),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "$label: $value",
            style: const TextStyle(fontSize: 14),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.copy, size: 20),
          tooltip: AppStrings.copy,
          onPressed: onCopy,
        ),
        if (onOpen != null)
          IconButton(
            icon: const Icon(Icons.open_in_browser, size: 20),
            tooltip: AppStrings.openInBrowser,
            onPressed: onOpen,
          ),
      ],
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${AppLocalizations.of(context).copied}: $text")),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url.startsWith('http') ? url : 'https://$url');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch $url');
    }
  }
}
