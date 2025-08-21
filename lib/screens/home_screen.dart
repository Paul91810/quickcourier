import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quickcourier/core/constants/app_sizes.dart';
import 'package:quickcourier/models/booking_details_model.dart';
import 'package:quickcourier/screens/booking_screen.dart';
import 'package:quickcourier/screens/shipment_tracking_screen.dart';
import 'package:quickcourier/widgets/button.dart';
import 'package:quickcourier/widgets/custom_appbar.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingBox = Hive.box<BookingModel>('bookings');

    return Scaffold(
      appBar: CustomAppbar(title: "Home"),
      body: Padding(
        padding: AppSizes.commonPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            Row(
              children: [
                Expanded(
                  child: CustomAppElvatedButton(
                    child: const Text('Book Courier'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingScreen(),
                        ),
                      );
                    },
                  ),
                ),
                AppSizes.appWidth10(context),
                Expanded(
                  child: CustomAppElvatedButton(
                    child: const Text('Track Shipment'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ShipmentTrackingScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            AppSizes.appHeight20(context),

           
            Text(
              "Recent Bookings",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            AppSizes.appHeight10(context),

 
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: bookingBox.listenable(),
                builder: (context, Box<BookingModel> box, _) {
                  if (box.isEmpty) {
                    return const Center(
                      child: Text("You didn’t book anything yet."),
                    );
                  }

                  return GridView.builder(
                    itemCount: box.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final booking = box.getAt(index)!;

                      return Card(
                        elevation: 3,
                        color: Theme.of(context).cardColor, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             
                              Text(
                                " ${booking.trackingId}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface, 
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const Divider(),

                         
                              Text(
                                "From: ${booking.senderName}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                              ),

                             
                              Text(
                                "To: ${booking.receiverName}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                              ),

                              const Spacer(),

                              
                              Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.copy,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary, 
                                  ),
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(
                                        text: booking.trackingId,
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Tracking ID copied: ${booking.trackingId}",
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
