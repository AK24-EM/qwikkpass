import 'package:flutter/material.dart';
import 'package:qwikpass/core/theme/app_theme.dart';
import 'package:qwikpass/core/widgets/chips_and_tags.dart';

class EventCarousel extends StatelessWidget {
  final List<EventCardData> events;

  const EventCarousel({
    Key? key,
    required this.events,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: events.length,
        itemBuilder: (context, index) {
          return _buildEventCard(context, events[index]);
        },
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, EventCardData event) {
    return GestureDetector(
      onTap: () {
        // Navigate to event detail
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: AppTheme.cardDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.borderGray,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(11),
              ),
              child: Container(
                height: 140,
                width: double.infinity,
                color: AppTheme.surfaceDark,
                child: event.imageUrl != null
                    ? Image.network(
                        event.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildImagePlaceholder(),
                      )
                    : _buildImagePlaceholder(),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tag
                  StatusTag(
                    label: event.tag,
                    color: event.tagColor,
                  ),

                  const SizedBox(height: 8),

                  // Title
                  Text(
                    event.title,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 13,
                          height: 1.3,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),

                  // Venue
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 10,
                        color: AppTheme.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.venue,
                          style: AppTheme.monospaceXSmall(context).copyWith(
                            fontSize: 9,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Date
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 10,
                        color: AppTheme.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.date,
                          style: AppTheme.monospaceXSmall(context).copyWith(
                            fontSize: 9,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'FROM',
                        style: AppTheme.monospaceXSmall(context).copyWith(
                          fontSize: 8,
                        ),
                      ),
                      Text(
                        event.price,
                        style: AppTheme.monospaceMedium(context).copyWith(
                          color: AppTheme.primaryYellow,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: AppTheme.surfaceDark,
      child: Stack(
        children: [
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.accentPurple.withOpacity(0.3),
                  AppTheme.surfaceDark,
                ],
              ),
            ),
          ),
          // Icon
          const Center(
            child: Icon(
              Icons.music_note,
              size: 48,
              color: AppTheme.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class EventCardData {
  final String title;
  final String venue;
  final String date;
  final String tag;
  final Color tagColor;
  final String price;
  final String? imageUrl;

  const EventCardData({
    required this.title,
    required this.venue,
    required this.date,
    required this.tag,
    required this.tagColor,
    required this.price,
    this.imageUrl,
  });
}
