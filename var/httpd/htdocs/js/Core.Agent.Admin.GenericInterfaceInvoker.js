// --
// Core.Agent.Admin.GenericInterfaceInvoker.js - provides the special module functions for the GenericInterface invoker.
// Copyright (C) 2001-2011 OTRS AG, http://otrs.org/
// --
// $Id: Core.Agent.Admin.GenericInterfaceInvoker.js,v 1.1 2011-06-20 17:35:40 cr Exp $
// --
// This software comes with ABSOLUTELY NO WARRANTY. For details, see
// the enclosed file COPYING for license information (AGPL). If you
// did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
// --

"use strict";

var Core = Core || {};
Core.Agent = Core.Agent || {};
Core.Agent.Admin = Core.Agent.Admin || {};

/**
 * @namespace
 * @exports TargetNS as Core.Agent.Admin.GenericInterfaceInvoker
 * @description
 *      This namespace contains the special module functions for the GenericInterface invoker module.
 */
Core.Agent.Admin.GenericInterfaceInvoker = (function (TargetNS) {

    /**
     * @variable
     * @private
     *     This variable stores the parameters that are passed from the DTL and contain all the data that the dialog needs.
     */
    var DialogData = [];

    /**
     * @function
     * @param {Object} Params, initialization and internationalization parameters.
     * @return nothing
     *      This function initialize correctly all other function according to the local language
     */
    TargetNS.Init = function (Params) {
        TargetNS.WebserviceID = parseInt(Params.WebserviceID, 10);
        TargetNS.Invoker      = Params.Invoker;
        TargetNS.Action       = Params.Action;
        TargetNS.Localization = Params.Localization;
    };

    TargetNS.ToogleEventSelect = function (SelectedEventType) {
        $('.EventList').addClass('Hidden');
        $('#' + SelectedEventType + 'Event').removeClass('Hidden');
    };


    /**
     * @function
     * @param {String} EventType, the type of event trigger to assign to an invoker
     * i.e ticket or article
     * @return nothing
     *      This function calls the AddEvent action on the server
     */
    TargetNS.AddEvent = function (EventType) {
        var NewEvent;

        NewEvent = $('#'+ EventType + 'Event').val();

        if ( $('#Asynchronous').attr('checked') ) {
            window.location.href =Core.Config.Get('Baselink') + 'Action='+ TargetNS.Action +';Subaction=AddEvent;NewEvent=' + NewEvent + ';Asynchronous=1' + ';WebserviceID=' + TargetNS.WebserviceID + ';Invoker=' + TargetNS.Invoker;
        }
        else {
            window.location.href =Core.Config.Get('Baselink') + 'Action='+ TargetNS.Action +';Subaction=AddEvent;NewEvent=' + NewEvent + ';WebserviceID=' + TargetNS.WebserviceID + ';Invoker=' + TargetNS.Invoker;
        }
    };

    /**
     * @function
     * @param {EventObject} event object of the clicked element.
     * @return nothing
     *      This function shows a confirmation dialog with 2 buttons
     */
    TargetNS.ShowDeleteDialog = function(Event){
        Core.UI.Dialog.ShowContentDialog(
            $('#DeleteDialogContainer'),
            TargetNS.Localization.DeleteInvokerMsg,
            '240px',
            'Center',
            true,
            [
               {
                   Label: TargetNS.Localization.DeleteMsg,
                   Function: function () {
                       var Data = {
                            Action: TargetNS.Action,
                            Subaction: 'DeleteAction',
                            WebserviceID: TargetNS.WebserviceID,
                            Invoker: TargetNS.Invoker
                        };

                        Core.AJAX.FunctionCall(Core.Config.Get('CGIHandle'), Data, function (Response) {
                            if (!Response || !Response.Success) {
                                alert(TargetNS.Localization.CommunicationErrorMsg);
                                return;
                            }

                            window.location.href =Core.Config.Get('Baselink') + 'Action=AdminGenericInterfaceWebservice;Subaction=Change;WebserviceID=' + TargetNS.WebserviceID;

                        }, 'json');

                       Core.UI.Dialog.CloseDialog($('#DeleteDialog'));
                   }
               },
               {
                   Label: TargetNS.Localization.CancelMsg,
                   Function: function () {
                       Core.UI.Dialog.CloseDialog($('#DeleteDialog'));
                   }
               }
           ]
        );

        Event.stopPropagation();
    };

    /**
     * @function
     * @param {EventObject} event object of the clicked element.
     * @return nothing
     *      This function shows a confirmation dialog with 2 buttons
     */
    TargetNS.ShowDeleteEventDialog = function(Event){
        var LocalDialogData;

        // get global saved DialogData for this function
        LocalDialogData = DialogData[$(Event.target).attr('id')];
        console.log($(Event.target).attr('id'));
        console.log(DialogData);
        console.log(LocalDialogData);
        Core.UI.Dialog.ShowContentDialog(
            $('#DeleteEventDialogContainer'),
            TargetNS.Localization.DeleteEventMsg,
            '240px',
            'Center',
            true,
            [
               {
                   Label: TargetNS.Localization.DeleteMsg,
                   Function: function () {
                       var Data = {
                            Action: TargetNS.Action,
                            Subaction: 'DeleteEvent',
                            WebserviceID: TargetNS.WebserviceID,
                            Invoker: TargetNS.Invoker,
                            EventName: LocalDialogData.EventName
                        };
                        console.log(Data);
                        Core.AJAX.FunctionCall(Core.Config.Get('CGIHandle'), Data, function (Response) {
                            if (!Response || !Response.Success) {
                                alert(TargetNS.Localization.CommunicationErrorMsg);
                                return;
                            }

                            window.location.href =Core.Config.Get('Baselink') + 'Action=' + Data.Action + ';Subaction=Change'+ ';Invoker='+ Data.Invoker + ';WebserviceID=' + TargetNS.WebserviceID;

                        }, 'json');

                       Core.UI.Dialog.CloseDialog($('#DeleteEventDialog'));
                   }
               },
               {
                   Label: TargetNS.Localization.CancelMsg,
                   Function: function () {
                       Core.UI.Dialog.CloseDialog($('#DeleteEventDialog'));
                   }
               }
           ]
        );

        Event.stopPropagation();
        Event.preventDefault();
    };

    /**
     * @function
     * @param {Object} Data a control structure that contains the jQueryObjectID,
     * jQueryObjectSelector and the Invoker Event Trigger Name.
     * @return nothing
     *      This function binds a "trash can" link from the invoker event triggers table to the
     *      function that opens a dialog to delete the event trigger
     */
    TargetNS.BindDeleteEventDialog = function (Data) {
        DialogData[Data.ElementID] = Data;

        // binding a click event to the defined element
        $(DialogData[Data.ElementID].ElementSelector).bind('click', TargetNS.ShowDeleteEventDialog);
    };

    return TargetNS;
}(Core.Agent.Admin.GenericInterfaceInvoker || {}));