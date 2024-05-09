import { application } from "./application";

import FollowController from "./follow_controller";
import GreenSetController from "./green_set_controller";
import MainController from "./main_controller";
import ModalController from "./modal_controller";
import PreviewController from "./preview_controller";
import ProfileController from "./profile_controller";
import ResetFormController from "./reset_form_controller";
import SearchController from "./search_controller";
import StorieController from "./storie_controller";
import StoryController from "./story_controller";
import StoryUsersController from "./story_users_controller";
import ThemeController from "./theme_controller";

application.register("follow", FollowController);
application.register("green_set", GreenSetController);
application.register("storie", StorieController);
application.register("story", StoryController);
application.register("story_users", StoryUsersController);
application.register("main", MainController);
application.register("modal", ModalController);
application.register("preview", PreviewController);
application.register("profile", ProfileController);
application.register("reset_form", ResetFormController);
application.register("search", SearchController);
application.register("theme", ThemeController);
