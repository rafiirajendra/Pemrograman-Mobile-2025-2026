import 'package:flutter/material.dart';
import '../models/data_layer.dart';
import '../provider/plan_provider.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({super.key, required this.plan});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late ScrollController scrollController;
  Plan get plan => widget.plan;
  final Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        if (!mounted) return;
        // Unfocus instead of requesting a new FocusNode
        FocusScope.of(context).unfocus();
      });
  }

  @override
  void dispose() {
    scrollController.dispose();
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(plan.name)),
      body: ValueListenableBuilder<List<Plan>>(
        valueListenable: plansNotifier,
        builder: (context, plans, child) {
          final currentPlan = plans.firstWhere((p) => p.name == plan.name, orElse: () => plan);
          return Column(
            children: [
              Expanded(child: _buildList(currentPlan)),
              SafeArea(child: Text(currentPlan.completenessMessage)),
            ],
          );
        },
      ),
      floatingActionButton: _buildAddTaskButton(context),
    );
  }

  Widget _buildAddTaskButton(BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        // Use the latest plan from provider
        final idx = planNotifier.value.indexWhere((p) => p.name == plan.name);
        if (idx == -1) return;
        final livePlan = planNotifier.value[idx];

        final updatedTasks = List<Task>.from(livePlan.tasks)..add(const Task());
        final updatedPlans = List<Plan>.from(planNotifier.value)
          ..[idx] = Plan(name: livePlan.name, tasks: updatedTasks);
        planNotifier.value = updatedPlans;
      },
    );
  }

  Widget _buildList(Plan plan) {
    if (plan.tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.task, size: 100, color: Colors.grey),
            Text(
              'Belum ada tugas dalam plan ini.',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) => _buildTaskTile(plan.tasks[index], index, context),
    );
  }

  Widget _buildTaskTile(Task task, int index, BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);

    // Ensure controller exists and stays in sync with current task text
    final controller = _controllers.putIfAbsent(index, () => TextEditingController(text: task.description));
    if (controller.text != task.description) {
      controller.text = task.description;
      controller.selection = TextSelection.collapsed(offset: controller.text.length);
    }

    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          final planIndex = planNotifier.value.indexWhere((p) => p.name == plan.name);
          if (planIndex == -1) return;
          final livePlan = planNotifier.value[planIndex];

          final updatedTasks = List<Task>.from(livePlan.tasks)
            ..[index] = Task(
              description: livePlan.tasks[index].description,
              complete: selected ?? false,
            );

          planNotifier.value = List<Plan>.from(planNotifier.value)
            ..[planIndex] = Plan(name: livePlan.name, tasks: updatedTasks);
        },
      ),
      title: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Masukkan deskripsi tugas',
          border: InputBorder.none,
        ),
        onChanged: (text) {
          final planIndex = planNotifier.value.indexWhere((p) => p.name == plan.name);
          if (planIndex == -1) return;
          final livePlan = planNotifier.value[planIndex];

          final updatedTasks = List<Task>.from(livePlan.tasks)
            ..[index] = Task(
              description: text,
              complete: livePlan.tasks[index].complete,
            );

          planNotifier.value = List<Plan>.from(planNotifier.value)
            ..[planIndex] = Plan(name: livePlan.name, tasks: updatedTasks);
        },
      ),
    );
  }
}
