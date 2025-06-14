import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trust_zone/utils/app_strings.dart';
import 'package:trust_zone/utils/color_managers.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../domain/entities/branch_photo.dart';
import '../cubit/place_details_cubit.dart';
import '../cubit/place_details_state.dart';

class PlaceImageSection extends StatelessWidget {
  final int branchId;
  final dynamic placeDetails;
  final List<BranchPhotoEntity> photos;

  PlaceImageSection({
    super.key,
    required this.branchId,
    this.placeDetails,
    required this.photos,
  });

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceDetailsCubit, PlaceDetailsState>(
      builder: (context, state) {
        if (state is PlaceDetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PlaceDetailsLoaded) {
          final branch = state.branchEntity;

          return Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  photos.isNotEmpty
                      ? SizedBox(
                    height: 300,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: photos.length,
                      itemBuilder: (context, index) {
                        final photoUrl = photos[index].photoUrl;
                        return Image.network(
                          photoUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: ColorManager.primary,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).failedToLoadImage,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(child: CircularProgressIndicator());
                          },
                        );
                      },
                    ),
                  )
                      : Container(
                    height: 300,
                    width: double.infinity,
                    color: ColorManager.primary,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).noImage,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  if (photos.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: photos.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: ColorManager.primary,
                          dotColor: Colors.grey.shade400,
                          dotHeight: 8,
                          dotWidth: 8,
                          expansionFactor: 3,
                          spacing: 5,
                        ),
                      ),
                    ),
                ],
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
                              context: context,
                              icon: Icons.location_on,
                              label: AppLocalizations.of(context).address,
                              value: branch.address,
                              onCopy: () => _copyToClipboard(context, branch.address),
                            ),
                            const Divider(),
                            _infoRow(
                              context: context,
                              icon: Icons.phone,
                              label: AppLocalizations.of(context).phone,
                              value: branch.phone,
                              onCopy: () => _copyToClipboard(context, branch.phone),
                            ),
                            const Divider(),
                            _infoRow(
                              context: context,
                              icon: Icons.language,
                              label: AppLocalizations.of(context).website,
                              value: branch.website,
                              onCopy: () => _copyToClipboard(context, branch.website),
                              onOpen: () => _launchUrl(branch.website),
                            ),
                            const Divider(),

                            // ✅ Opening hours
                            _infoRow(
                              context: context,
                              icon: Icons.access_time,
                              label: AppLocalizations.of(context).workingHours,
                              value: "${branch.openingTime} - ${branch.closingTime}",
                              onCopy: () => _copyToClipboard(
                                context,
                                "${branch.openingTime} - ${branch.closingTime}",
                              ),
                            ),
                            const Divider(),

                            // ✅ Feature names
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.check_circle, color: Colors.teal),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context).features,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      ...branch.featureNames.map(
                                            (feature) => Text(
                                          "• $feature",
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                      children: [
                        const Icon(Icons.info_outline, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context).details,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _infoRow({
    required BuildContext context,
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
