package;

import kha.System;
import kha.Assets;
import kha.Scheduler;

class Main {
	public static function main() {
		System.init({title: "Project", width: 800, height: 600}, function () {
			Assets.loadEverything(function(){
				System.notifyOnRender(Project.the.render);
				Scheduler.addTimeTask(Project.the.update, 0, 1 / 60);
			});
		});
	}
}
