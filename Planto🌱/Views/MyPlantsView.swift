import SwiftUI

struct MyPlantsView: View {
    @State private var viewModel = PlantsViewModel()

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                content

                if viewModel.hasPlants {
                    addButton
                        .padding(24)
                }
            }
            .navigationTitle("My Plants 🌱")
            .sheet(item: $viewModel.activeSheet) { sheet in
                SetReminderView(
                    plant: sheet.plant,
                    onSave: { plant in
                        withAnimation { viewModel.save(plant) }
                    },
                    onDelete: { plant in
                        withAnimation { viewModel.delete(plant) }
                    }
                )
            }
        }
        .sensoryFeedback(.success, trigger: viewModel.allDone) { _, isDone in isDone }
        .task {
            await viewModel.requestNotificationPermission()
        }
    }

    @ViewBuilder
    private var content: some View {
        if !viewModel.hasPlants {
            StartJourneyView { viewModel.startAdding() }
        } else if viewModel.allDone {
            AllDoneView()
                .transition(.scale.combined(with: .opacity))
        } else {
            plantList
        }
    }

    private var plantList: some View {
        VStack(spacing: 16) {
            Divider()

            WateringProgressView(
                message: viewModel.progressMessage,
                progress: viewModel.progress
            )
            .padding(.top, 8)

            List {
                ForEach(viewModel.plants) { plant in
                    PlantRowView(
                        plant: plant,
                        onToggle: {
                            withAnimation(.snappy) { viewModel.toggleWatered(plant) }
                        },
                        onEdit: { viewModel.startEditing(plant) }
                    )
                    .listRowBackground(Color.clear)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            withAnimation { viewModel.delete(plant) }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }

    private var addButton: some View {
        Button {
            viewModel.startAdding()
        } label: {
            Image(systemName: "plus")
                .font(.title2.weight(.semibold))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
        }
        .glassEffect(.regular.tint(.buttonGreen).interactive(), in: .circle)
    }
}

#Preview {
    MyPlantsView()
        .preferredColorScheme(.dark)
}
