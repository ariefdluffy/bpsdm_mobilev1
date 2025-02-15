import 'package:bpsdm_mobilev1/providers/api_provider.dart';
import 'package:bpsdm_mobilev1/screen/widget/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FaqScreen extends ConsumerWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faqAsyncValue = ref.watch(faqProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final textController = ref.watch(textEditingControllerProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('FAQ Pelatihan'),
        ),
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: TextField(
                controller: textController,
                onChanged: (searchQuery) =>
                    ref.read(searchQueryProvider.notifier).state = searchQuery,
                decoration: InputDecoration(
                  labelText: "Cari Pertanyaan...",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            textController.clear();
                            FocusScope.of(context).unfocus();
                            ref.read(searchQueryProvider.notifier).state = "";
                          })
                      : null,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: faqAsyncValue.when(
                data: (faqs) {
                  final filteredFAQ = faqs.where((faq) {
                    return faq.question
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase());
                  }).toList();

                  return filteredFAQ.isEmpty
                      ? const Center(child: Text("Tidak ada hasil"))
                      : ListView.builder(
                          itemCount: filteredFAQ.length,
                          itemBuilder: (context, index) {
                            String contentAnswer = filteredFAQ[index].answer;
                            bool containsHtml = contentAnswer.contains("<") &&
                                contentAnswer.contains(">");
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4),
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ExpansionTile(
                                  title: Text(
                                    filteredFAQ[index].question,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  leading: const Icon(Icons.question_answer,
                                      color: Colors.blueAccent),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8),
                                      // child:
                                      // Html(data: filteredFAQ[index].answer),
                                      child: containsHtml
                                          ? Html(data: contentAnswer)
                                          : Text(
                                              contentAnswer,
                                              textAlign: TextAlign.justify,
                                            ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                },
                loading: () => Column(
                  children: List.generate(
                    8,
                    (index) => const ShimmerBox(),
                  ),
                ),
                error: (error, stack) => Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
