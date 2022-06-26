import React, { useState, useEffect } from 'react';
import { Grid, Button, Typography } from '@material-ui/core';
import TextField from "@material-ui/core/TextField";
import Aktivitäten from "./Aktivitäten";
import theme from "../Login";
import { ThemeProvider } from '@mui/material';

export default function Anwesenheit() {
    const [intervall, setIntervall] = useState("0h 0min");
    const [start, setStart] = useState(null);
    const [ende, setEnde] = useState(null);
    let defaultTime = new Date()
    defaultTime.setHours(0)
    defaultTime.setMinutes(0)
    defaultTime.setSeconds(0)
    const [endeTime, setEndeTime] = useState(defaultTime);
    const [startTime, setStartTime] = useState(defaultTime);
    const [intervallTime, setIntervallTime] = useState("");

    useEffect(() => {
        let defaultTime = new Date()
        defaultTime.setHours(0)
        defaultTime.setMinutes(0)
        defaultTime.setSeconds(0)
        console.log("defaultTime", defaultTime)

        console.log("Default start (Date):", startTime)
        console.log("Default ende (Date):", endeTime)
        //setIntervall(defaultTime.toLocaleTimeString(navigator.language, { hour: '2-digit', minute: '2-digit' }))
        setStart(defaultTime.toLocaleTimeString(navigator.language, { hour: '2-digit', minute: '2-digit' }))
        setEnde(defaultTime.toLocaleTimeString(navigator.language, { hour: '2-digit', minute: '2-digit' }))
    }, []
    );

    const changeStart = (event) => {
        var time = event.target.value;
        setStart(time)
        var start1 = new Date()
        var timeInInt = time.split(":");
        console.log(timeInInt[0], timeInInt[1])
        start1.setHours(timeInInt[0])
        start1.setMinutes(timeInInt[1])
        console.log("sjahdsajknjcd Start als Date nach Änderung:", start1)
        //console.log("Ende als Date nach Änderung:",endeTime)
        setStartTime(start1)
    }

    const changeEnde = (event) => {
        var time = event.target.value;
        setEnde(time)
        var ende1 = new Date()
        var timeInInt = time.split(":");
        console.log(timeInInt[0], timeInInt[1])
        ende1.setHours(timeInInt[0])
        ende1.setMinutes(timeInInt[1])
        console.log("asgvasbhsabkdas Ende als Date nach Änderung:", ende1)
        setEndeTime(ende1)
        setTime()
    }

    function setTime() {
        /* An dieser Stelle Problem: der zuletzt gesetzte wert stimmt, aber der andere nicht */
        console.log("Time is Set!!")
        console.log("Start:", startTime)
        console.log("Ende:", endeTime)
        let newIntervall = new Date();
        newIntervall = (endeTime - startTime)
        console.log("SetTime: start (Date):", startTime)
        console.log("SetTime: ende (Date):", endeTime)
        console.log("Intervallzeit als Date:", newIntervall)

        var msec = newIntervall;
        var hh = Math.floor(msec / 1000 / 60 / 60);
        msec -= hh * 1000 * 60 * 60;
        var mm = Math.floor(msec / 1000 / 60);
        msec -= mm * 1000 * 60;
        var newIntervallObject = new Date();
        newIntervallObject.setHours(hh)
        newIntervallObject.setMinutes(mm)
        //console.log(hh + " Stunden" + " " + mm + " Minuten")
        let newIntervallString = hh + "h " + mm + "min"
        console.log("Intervall in Stunde u Minuten:", newIntervallString)
        setIntervall(newIntervallString)
    };
    return (
        <div>
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>

                <Grid item xs={3} style={{ alignSelf: "end" }}>
                    <Typography variant="h5" >Anwesenheit</Typography>
                </Grid>
                <Grid item xs={3}>
                    <form noValidate>
                        <TextField
                            className="time"
                            label="Start"
                            type="time"
                            defaultValue="00:00"
                            InputLabelProps={{
                                shrink: true
                            }}
                            onChange={changeStart}
                        />
                    </form>
                </Grid>
                <Grid item xs={3}>
                    <form noValidate>
                        <TextField
                            className="time"
                            label="Ende"
                            type="time"
                            defaultValue="00:00"
                            InputLabelProps={{
                                shrink: true
                            }}
                            onChange={changeEnde}
                        />
                    </form>
                </Grid>
                <Grid item xs={3} style={{ alignSelf: "end" }}>
                    <Grid item >
                        <Button variant="outlined" onClick={setTime} style={{ borderWidth: "2px", borderRadius: "25px", height: "50px", minWidth: "180px", color: "#00bcd4" }} >
                            Buchen
                        </Button>

                    </Grid>
                </Grid>


            </div>

            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginTop: "1rem" }}>

                <Grid item xs={3} style={{ alignSelf: "end" }}>
                    <Typography variant="h5" >Pause</Typography>
                </Grid>
                <Grid item xs={3}>
                    <form noValidate>
                        <TextField
                            className="time"
                            label="Start"
                            type="time"
                            defaultValue="00:00"
                            InputLabelProps={{
                                shrink: true
                            }}
                            onChange={changeStart}
                        />
                    </form>
                </Grid>
                <Grid item xs={3}>
                    <form noValidate>
                        <TextField
                            className="time"
                            label="Ende"
                            type="time"
                            defaultValue="00:00"
                            InputLabelProps={{
                                shrink: true
                            }}
                            onChange={changeEnde}
                        />
                    </form>
                </Grid>
                <Grid item xs={3} style={{ alignSelf: "end" }}>
                        <Button variant="outlined" onClick={setTime} style={{ borderWidth: "2px", borderRadius: "25px", height: "50px", minWidth: "180px", color: "#00bcd4 !important" }} >
                            Buchen
                        </Button>

                </Grid>

            </div>
        </div>

    )
}
