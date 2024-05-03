import { application } from "./application";

import FollowController from "./follow_controller";
import PreviewController from "./preview_controller";
import ModalController from "./modal_controller";
import ProfileController from "./profile_controller";
import ThemeController from "./theme_controller";
import MainController from "./main_controller";
import SearchController from "./search_controller";
import GreenSetController from "./green_set_controller";
import StorieController from "./storie_controller";
import StoryController from "./story_controller";
import StoryUsersController from "./story_users_controller";

application.register("follow", FollowController);
application.register("preview", PreviewController);
application.register("modal", ModalController);
application.register("profile", ProfileController);
application.register("theme", ThemeController);
application.register("main", MainController);
application.register("search", SearchController);
application.register("green_set", GreenSetController);
application.register("storie", StorieController);
application.register("story", StoryController);
application.register("story_users", StoryUsersController);
