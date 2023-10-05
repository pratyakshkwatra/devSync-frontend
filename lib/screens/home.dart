import 'package:devsync/main.dart';
import 'package:devsync/models.dart';
import 'package:devsync/utils/custom_delete_dialog.dart';
import 'package:devsync/utils/custom_dialog.dart';
import 'package:devsync/utils/custom_textfield_dialog.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = -1;
  bool selectedItem = false;
  List openProjects = [];
  @override
  void initState() {
    backend.getProjects(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
        title: const Text(
          "DevSync",
          style: TextStyle(
            fontStyle: FontStyle.normal,
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Your DevSpaces:",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showCustomTextfieldDialog(
                                context, Colors.white, "Add Projects", () {
                              if (mounted) {
                                setState(() {});
                              }
                            });
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: backend.projects.isNotEmpty
                            ? ListView.builder(
                                itemCount: backend.projects.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  Project project = backend.projects[index];
                                  return GestureDetector(
                                    onTap: () {
                                      if (selectedItem =
                                          true && currentIndex == index) {
                                        selectedItem = false;
                                        currentIndex = -1;
                                      } else {
                                        selectedItem = true;
                                        currentIndex = index;
                                      }

                                      setState(() {});
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Container(
                                        width: 200,
                                        decoration: BoxDecoration(
                                          gradient: const RadialGradient(
                                            colors: [
                                              Color(0xffAED8CC),
                                              Color.fromARGB(
                                                  255, 148, 227, 204),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Column(
                                            children: [
                                              Text(
                                                project.title,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const Divider(
                                                color: Colors.black,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                project.description,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Divider(
                                                color: Colors.black,
                                              ),
                                              Text(
                                                "Last Used:\n${project.lastUsed}",
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : SizedBox(
                                width: MediaQuery.of(context).size.width * 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: const RadialGradient(
                                          colors: [
                                            Color.fromARGB(255, 216, 174, 174),
                                            Color.fromARGB(255, 216, 174, 174),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Add atleast 1 project to continue",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !selectedItem
                        ? Container(
                            decoration: BoxDecoration(
                              gradient: const RadialGradient(
                                colors: [
                                  Color(0xffAED8CC),
                                  Color.fromARGB(255, 148, 227, 204),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Text(
                              "Select a DevSpace to continue",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (openProjects.contains(currentIndex)) {
                                    backend.closeAndCommit(() {
                                      if (mounted) {
                                        openProjects.remove(currentIndex);
                                        setState(() {});
                                      }
                                    }, backend.projects[currentIndex].id);
                                  } else {
                                    backend.openInVSCode(() {
                                      if (mounted) {
                                        openProjects.add(currentIndex);
                                        setState(() {});
                                      }
                                    }, backend.projects[currentIndex].id);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const RadialGradient(
                                      colors: [
                                        Color.fromARGB(255, 197, 197, 246),
                                        Color.fromARGB(255, 197, 197, 246),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.only(
                                    right: 15,
                                    left: 15,
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    !openProjects.contains(currentIndex)
                                        ? "Open project in VSCode"
                                        : "Close & Commit",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  backend.analyzeCode((String data) {
                                    if (mounted) {
                                      setState(() {});
                                    }
                                    showCustomAlertDialog(context, Colors.white,
                                        "Code Analysis", data, () {});
                                  }, backend.projects[currentIndex].id);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const RadialGradient(
                                      colors: [
                                        Color.fromARGB(255, 229, 197, 246),
                                        Color.fromARGB(255, 229, 197, 246),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.only(
                                    right: 15,
                                    left: 15,
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  child: const Text(
                                    "Analyze Code (DevSync AI)",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  backend.analyzeErrorCode((String data) {
                                    if (mounted) {
                                      setState(() {});
                                    }
                                    showCustomAlertDialog(context, Colors.white,
                                        "Error Analysis", data, () {});
                                  }, backend.projects[currentIndex].id);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const RadialGradient(
                                      colors: [
                                        Color.fromARGB(255, 197, 197, 246),
                                        Color.fromARGB(255, 197, 197, 246),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.only(
                                    right: 15,
                                    left: 15,
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  child: const Text(
                                    "Find Errors",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 150,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showCustomDeleteDialog(context, () {
                                    backend.deleteProject(() {
                                      if (mounted) {
                                        setState(() {});
                                      }
                                    }, backend.projects[currentIndex].id);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const RadialGradient(
                                      colors: [
                                        Color.fromARGB(255, 249, 149, 170),
                                        Color.fromARGB(255, 249, 149, 170),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                      right: 15,
                                      left: 15,
                                      top: 5,
                                      bottom: 5,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                          size: 40,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Delete Project",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
