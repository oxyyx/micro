(function(Micro) {
	Micro.ERROR_DISPLAY_HIDE_DELAY = 3000;
	Micro.INFO_DISPLAY_HIDE_DELAY  = 3000;

	/**
	 * Initializes the Micro JS components.
	 */
	Micro.initialize = function initialize() {
		handleFlashMessageLoad('#flash-error', Micro.ERROR_DISPLAY_HIDE_DELAY);
		handleFlashMessageLoad('#flash-info', Micro.INFO_DISPLAY_HIDE_DELAY);
	};

	/**
	 * Handles displaying flash messages on load;
	 * Hides a flash message when it contains no content. Otherwise it hides the message after the specified delay.
	 * If the delay is 0, the users has to close the message by himself.
	 * 
	 * @param  {HTMLElement} 	component Component to act on.
	 * @param  {Integer} 		delay     Delay before hiding the component if it has content.
	 */
	function handleFlashMessageLoad(component, delay) {
		var $component = $(component);
		var componentContent = $component.html();

		if (componentContent) {
			$component.show();

			if (delay >= 0) {
				setTimeout(function() {
					$component.hide();
				}, delay);
			} 
		} else {
			$component.hide();
		}
	}
}(window.Micro = window.Micro || {}));
