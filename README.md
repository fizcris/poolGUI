# poolGUI
GUI created in Qt Creator 5.14 to control an indoor swimming pool heating system coupled with a heating floor installation in order to control pool water temperature and ambient temperature.

The system can be used as a <span style="color:orange">heating system</span> by using an enviromental friendly boiler or it can act as a <span style="color:lightblue">refrigeration system</span> employing the pool as heat sink. 

![Main Window](./resources/screenshot.gif)

***
### Hardware
- Raspberry Pi 4 (Raspberry Pi OS with desktop )
### Project hardware
- Arduino Mega 2560
- Custom power source board
- Custom Arduino shield 

### Communications
- UART serial comunications with custom protocol
- The protocol is based on [this](https://github.com/vigasan/SerialCom) with some modifications for robustness
    - Lightweight
    - It has message integrity check by checksum
    - It lacks of error handling
    - It lacks of acknoledgment


### Improvements [TODOs]:
- Clear unused code (Themes...)
- Add extra configuration screen for hyperparameters
- Add a decimal point on temperature dials
- Fix decades number jumping one position when using arrows in dials

- In refrigeration mode:
    - Add control by pool delta
    - Add extra label showing pool delta
- In heat mode:
    - Do not start pumps until a minimum temperature is reached   
- Design new hardware with extra inputs to detect valve position (active when ground)
- Visualice pumps/valves icons dependign on actual state rather on scenario based 
- Switch to CAN bus
    - Error message handling
    - Acknoledgment of messages
- Add fan control hardware and software

***
## Instalation details

<table>
    <tr>
        <td>
            <img src="resources/schema.jpg" alt="schema" width="400" />
        </td>
        <td>
            <img src="resources/pool.jpg" alt="pool rendering" width="400" />
        </td>
    </tr>
    <tr>
        <td>
            <img src="resources/instalation.jpg" alt="pool rendering" width="400" />
        </td>
        <td>
            <img src="resources/screen.jpg" alt="pool rendering" width="400" />
        </td>
    </tr>
    <tr>
        <td colspan="2">
        <img src="resources/result.jpg" alt="pool rendering" width="800" />
        </td>
    </tr>
</table>
