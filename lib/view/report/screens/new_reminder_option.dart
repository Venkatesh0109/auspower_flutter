// import 'package:auspower_flutter/common/widgets/text_fields.dart';
// import 'package:auspower_flutter/theme/palette.dart';
// import 'package:auspower_flutter/utilities/extensions/context_extention.dart';
// import 'package:auspower_flutter/view/homescreen/screen/company_screen.dart';
// import 'package:flutter/material.dart';

// class NewReminderOptionScreen extends StatefulWidget {
//   const NewReminderOptionScreen({super.key});

//   @override
//   State<NewReminderOptionScreen> createState() =>
//       _NewReminderOptionScreenState();
// }

// class _NewReminderOptionScreenState extends State<NewReminderOptionScreen> {
//   TextEditingController valid1Cont = TextEditingController();
//   TextEditingController valid2Cont = TextEditingController();
//   TextEditingController valid3Cont = TextEditingController();

//   TextEditingController valid4Cont = TextEditingController();
//   TextEditingController firstReminderCont = TextEditingController();
//   TextEditingController secondReminderCont = TextEditingController();

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: InkWell(
//             onTap: () => Navigator.pop(context),
//             child: const Icon(Icons.arrow_back_ios)),
//         surfaceTintColor: Colors.transparent,
//         title: Text(
//           'New Reminder Option',
//           style: const TextStyle(
//             fontFamily: "Mulish",
//             color: Colors.black,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         iconTheme: const IconThemeData(
//           color: Colors.grey, // Change your color here
//         ),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             children: [
//               Expanded(
//                 child: ListView(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         boxShadow: primaryShadow,
//                         borderRadius: BorderRadius.circular(16),
//                         color: Colors.white,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           headerText("Validation 1"),
//                           TextFormFieldCustomised(
//                               controller: valid1Cont,
//                               hint: "Enter Valid 1",
//                               error: "Validation 1"),
//                           const SizedBox(height: 12),
//                           headerText("Validation 2"),
//                           TextFormFieldCustomised(
//                               controller: valid2Cont,
//                               hint: "Enter Valid 2",
//                               error: "Validation 2"),
//                           const SizedBox(height: 12),
//                           headerText("Validation 3"),
//                           TextFormFieldCustomised(
//                               controller: valid3Cont,
//                               hint: "Enter Valid 3",
//                               error: "Validation 3"),
//                           SizedBox(height: 12),
//                           headerText("Type"),
//                           SizedBox(height: 6),
//                           SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Row(
//                                 children: List.generate(8, (index) {
//                                   return Padding(
//                                     padding: const EdgeInsets.only(right: 12.0),
//                                     child: Column(
//                                       children: [
//                                         Container(
//                                           height: 50,
//                                           width: 50,
//                                           decoration: const BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             color: Colors.deepPurple,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 6),
//                                         const Text(
//                                           "Manage",
//                                           style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 }),
//                               ))
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         boxShadow: primaryShadow,
//                         borderRadius: BorderRadius.circular(16),
//                         color: Colors.white,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           headerText("Validation 4"),
//                           TextFormFieldCustomised(
//                               hint: "Enter Valid 4",
//                               controller: valid4Cont,
//                               error: "Validation 4"),
//                           const SizedBox(height: 12),
//                           headerText("First Reminder"),
//                           TextFormFieldCustomised(
//                               controller: firstReminderCont,
//                               hint: "Enter First Reminder",
//                               error: "First Reminder"),
//                           const SizedBox(height: 12),
//                           headerText("Second Reminder"),
//                           TextFormFieldCustomised(
//                               controller: secondReminderCont,
//                               hint: "Enter Second Reminder",
//                               error: "Second Reminder"),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                   ],
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   if (_formKey.currentState!.validate()) return;
//                 },
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Colors.deepPurple),
//                   child: Center(
//                     child: Text(
//                       "Create",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontSize: 16),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget headerText(String head) {
//     return Column(
//       children: [
//         Text(head,
//             style: TextStyle(
//                 color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 6),
//       ],
//     );
//   }
// }

// List<BoxShadow>? primaryShadow = [
//   BoxShadow(
//       color: Palette.secondary.withOpacity(.1),
//       blurRadius: .5,
//       spreadRadius: .5)
// ];

// class TextFormFieldCustomised extends StatefulWidget {
//   final TextEditingController controller;

//   final String? error, hint, initialValue;
//   final Widget? suffix, prefix;
//   final String? Function(String? input)? validator;
//   final BorderRadius? borderRadius;
//   final Function(String)? onChanged;
//   final VoidCallback? onTap;
//   final bool isBorderLess;

//   const TextFormFieldCustomised({
//     super.key,
//     required this.controller,
//     this.error,
//     this.validator,
//     this.suffix,
//     required this.hint,
//     this.prefix,
//     this.borderRadius,
//     this.onChanged,
//     this.onTap,
//     this.isBorderLess = false,
//     this.initialValue,
//   });

//   @override
//   State<TextFormFieldCustomised> createState() =>
//       _TextFormFieldCustomisedState();
// }

// class _TextFormFieldCustomisedState extends State<TextFormFieldCustomised> {
//   bool isVisible = false;
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: widget.controller,
//       onTapOutside: (event) => FocusScope.of(context).unfocus(),
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       validator: (i) {
//         String input = i ?? '';
//         // Checks if the field is optional and input is empty
//         if (input.isEmpty) {
//           return "The ${widget.error} is required";
//         }
//         // If the validator is not null custom validation logic to be performed
//         if (widget.validator != null) {
//           return widget.validator!(input);
//         }
//         // No validation errors
//         return null;
//       },
//       decoration: InputDecoration(
//           counterText: '',
//           errorStyle: const TextStyle(fontSize: 13, color: Palette.red),
//           filled: true,
//           fillColor: Colors.white,
//           // labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
//           hintStyle: TextStyle(
//               color: Palette.dark.withOpacity(.6),
//               fontSize: 14,
//               fontFamily: "Poppins"),
//           // labelText: widget.label,
//           hintText: widget.hint,
//           contentPadding: const EdgeInsets.all(16),
//           border: OutlineInputBorder(
//               borderSide:
//                   BorderSide(color: Colors.black.withOpacity(.6), width: 1.5),
//               borderRadius: BorderRadius.circular(12)),
//           errorBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Palette.red, width: 1.5),
//               borderRadius: BorderRadius.circular(12)),
//           enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Palette.muted, width: 1.5),
//               borderRadius: BorderRadius.circular(12)),
//           focusedBorder: OutlineInputBorder(
//               borderSide:
//                   BorderSide(color: Colors.black.withOpacity(.6), width: 1.5),
//               borderRadius: BorderRadius.circular(12))),
//     );
//   }
// }
