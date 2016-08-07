require_relative '../lib/task_manager'
require 'tempfile'

RSpec.describe TaskManager do
  let(:manager) { Object.new.extend(TaskManager) }
  describe "#tasks" do
    it "returns the list of tasks" do
      expect(manager.tasks).to be_a(described_class::TaskList)
    end
  end

  describe "#load_tasks/#dump" do
    it "uses marshalling to store tasks" do
      task = "go to work"
      path = Tempfile.new.path
      m1 = Object.new.extend(TaskManager)
      m2 = Object.new.extend(TaskManager)
      m1.save_path = path
      m2.save_path = path

      m1.tasks.add(task)
      m1.dump

      m2.load_tasks
      expect(m2.tasks.first.title).to eq(m1.tasks.first.title)
    end
  end

  describe described_class::TaskList do
    describe "#add" do
      it "generates a new task with the given string" do
        task = "go to work"
        manager.tasks.add task
        expect(manager.tasks.first.title).to eq(task)
      end
    end

    describe "#add!" do
      it "generates a new task with the given string" do
        manager.tasks.add "go to work"
        task = "go home"
        manager.tasks.add! task
        expect(manager.tasks.first.title).to eq(task)
      end
    end

    describe "#complete" do
      context "without argument" do
        it "removes the latest task" do
          task = "go to work"
          manager.tasks.add task
          manager.tasks.complete
          expect(manager.tasks.first.title).to_not eq(task)
        end
      end

      context "with integer argument" do
        it "removes the task at specified index" do
          task = "go to work"
          task2 = "go to school"
          manager.tasks.add task
          manager.tasks.add task2
          manager.tasks.complete(1)
          expect(manager.tasks.first.title).to eq(task)
          expect(manager.tasks.list.length).to eq(1)
        end
      end
    end

    describe "#delay" do
      context "without argument" do
        it "pushes back the current task one space" do
          task = "go to work"
          task2 = "go to school"
          manager.tasks.add task
          manager.tasks.add task2
          manager.tasks.delay
          expect(manager.tasks.first.title).to eq(task2)
          expect(manager.tasks.list.length).to eq(2)
        end
      end
    end
  end
end
