//
// Copyright (C) 2008 Irene Ruengeler
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
//

package inet.examples.sctp.wirelesscmttest;
import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.inet.INetworkNode;
import inet.node.dymo.DYMORouter;
import inet.physicallayer.apskradio.packetlevel.APSKScalarRadioMedium;
import inet.visualizer.integrated.IntegratedCanvasVisualizer;


network multiradio
{
    parameters:
        string hostType = default("WirelessHost");
        double testTimeout @unit(s) = default(0s);
        bool testing = default(false);
    submodules:
        visualizer: IntegratedCanvasVisualizer {
            @display("p=580,125");
        }
        cli1: <hostType> like INetworkNode {
            parameters:
                @display("p=61,142;i=device/card");
        }
        srv1: <hostType> like INetworkNode {
            parameters:
                @display("p=426,135;i=abstract/accesspoint");
        }
        router1: <hostType> like INetworkNode {
            parameters:
                @display("p=188,77;i=device/card");
        }
        router2: <hostType> like INetworkNode {
            parameters:
                @display("p=323,75;i=device/card");
        }
        router3: <hostType> like INetworkNode {
            parameters:
                @display("p=188,192;i=device/card");
        }
        router4: <hostType> like INetworkNode {
            parameters:
                @display("p=328,188;i=device/card");
        }
        radioMedium: APSKScalarRadioMedium {
            @display("p=83,15");
        }
        configurator: IPv4NetworkConfigurator {
            addStaticRoutes = false;
            addDefaultRoutes = false;
            addSubnetRoutes = false;
            config = xml("<config>"+
                    "<interface hosts='cli1' names='wlan0' address='10.1.1.1' netmask='255.255.255.0' />"+
                    "<interface hosts='cli1' names='wlan1' address='10.2.1.1' netmask='255.255.255.0' />"+
                    "<interface hosts='srv1' names='wlan0' address='10.1.3.1' netmask='255.255.255.0' />"+
                    "<interface hosts='srv1' names='wlan1' address='10.2.3.1' netmask='255.255.255.0' />"+
                    "<interface hosts='router1' names='wlan0' address='10.1.1.254' netmask='255.255.255.0' />"+
                    "<interface hosts='router1' names='wlan1' address='10.1.2.254' netmask='255.255.255.0' />"+
                    "<interface hosts='router2' names='wlan0' address='10.1.2.253' netmask='255.255.255.0' />"+
                    "<interface hosts='router2' names='wlan1' address='10.1.3.254' netmask='255.255.255.0' />"+
                    "<interface hosts='router3' names='wlan0' address='10.2.1.254' netmask='255.255.255.0' />"+
                    "<interface hosts='router3' names='wlan1' address='10.2.2.254' netmask='255.255.255.0' />"+
                    "<interface hosts='router4' names='wlan0' address='10.2.2.253' netmask='255.255.255.0' />"+
                    "<interface hosts='router4' names='wlan1' address='10.2.3.254' netmask='255.255.255.0' />"+
                    "<route hosts='cli1' destination='10.1.3.0' netmask='/24' gateway='router1' interface='wlan0'/>"+
                    "<route hosts='cli1' destination='10.2.0.0' netmask='/16' gateway='router3' interface='wlan1'/>"+
                    "<route hosts='srv1' destination='10.1.0.0' netmask='/16' gateway='router2' interface='wlan0'/>"+
                    "<route hosts='srv1' destination='10.2.0.0' netmask='/16' gateway='router4' interface='wlan1'/>"+
                    "<route hosts='router1' destination='10.1.1.1' netmask='/32' gateway='10.1.1.1' interface='wlan0'/>"+
                    "<route hosts='router1' destination='*' gateway='10.1.2.253' interface='wlan1'/>"+
                    "<route hosts='router2' destination='10.1.3.1' netmask='/32' gateway='10.1.3.1' interface='wlan0'/>"+
                    "<route hosts='router2' destination='*' gateway='10.1.2.254' interface='wlan1'/>"+
                    "<route hosts='router3' destination='10.2.1.1' netmask='/32' gateway='10.2.1.1' interface='wlan0'/>"+
                    "<route hosts='router3' destination='*' gateway='10.2.2.253' interface='wlan1'/>"+
                    "<route hosts='router4' destination='10.2.3.1' netmask='/32' gateway='10.2.3.1' interface='wlan0'/>"+
                    "<route hosts='router4' destination='*' gateway='10.2.2.254' interface='wlan1'/>"+
                    "</config>");
        }
    connections allowunconnected:
}

