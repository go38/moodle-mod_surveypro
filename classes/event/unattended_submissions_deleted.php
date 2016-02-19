<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

/**
 * mod_surveypro submission deleted event.
 *
 * @package    mod_surveypro
 * @copyright  2013 onwards kordan <kordan@mclink.it>
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

namespace mod_surveypro\event;

defined('MOODLE_INTERNAL') || die();

class unattended_submissions_deleted extends \core\event\base {
    /**
     * Set basic properties for the event.
     */
    protected function init() {
        $this->data['crud'] = 'd'; // One of these: c(reate), r(ead), u(pdate), d(elete).
        $this->data['edulevel'] = self::LEVEL_PARTICIPATING;
        $this->data['objecttable'] = 'surveypro_submission';
    }

    /**
     * Return localised event name.
     *
     * @return string
     */
    public static function get_name() {
        return get_string('event_unattended_submissions_deleted', 'mod_surveypro');
    }

    /**
     * Returns description of what happened.
     *
     * @return string
     */
    public function get_description() {
        return "Periodic check detected and deleted unattended submissions";
    }

    /**
     * Get URL related to the action.
     *
     * @return \moodle_url
     */
    public function get_url() {
        $paramurl = array();
        $paramurl['id'] = $this->contextinstanceid;
        return new \moodle_url('/mod/surveypro/view.php', $paramurl);
    }

    /**
     * Return legacy data for add_to_log().
     *
     * @return array
     */
    public function get_legacy_logdata() {
        // Override if you are migrating an add_to_log() call.
        return array($this->courseid, 'surveypro', 'unattended submission deleted',
            $this->get_url(), $this->objectid, $this->contextinstanceid);
    }

    /**
     * Return the legacy event name.
     *
     * @return string
     */
    public static function get_legacy_eventname() {
        // Override ONLY if you are migrating events_trigger() call.
        // MYPLUGIN_OLD_EVENT_NAME will come from surveypro for moodle 1.*
        // return 'MYPLUGIN_OLD_EVENT_NAME';
    }

    /**
     * Legacy event data if get_legacy_eventname() is not empty.
     *
     * @return stdClass
     */
    protected function get_legacy_eventdata() {
        // Override if you migrating events_trigger() call.
        /* $data = new \stdClass();
        $data->id = $this->objectid;
        $data->userid = $this->relateduserid;
        return $data; */
    }
}