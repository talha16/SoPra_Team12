import React, { useState, useEffect } from "react";
import { Grid, Fab, Button } from '@material-ui/core';
import TimelapseIcon from '@mui/icons-material/Timelapse';
import CloseIcon from '@mui/icons-material/Close';
import Dialog from '@mui/material/Dialog';
import DialogContent from '@mui/material/DialogContent';
import DialogTitle from '@mui/material/DialogTitle';
import DialogContentText from '@mui/material/DialogContentText';
import './modals/modal.css'
import '../index.css'

/**
 * @author [Talha Yildirim](https://github.com/talha16)
 * @author [Aykut Demir](https://github.com/AykutDemirr)
 * @author [Dennis Kühnberger](https://github.com/Dennis-248)
 * @author [Nicola Pany](https://github.com/NicolaPany)
*/

export default function Stundenübersicht(props) {


    const [stundenübersicht, setStundenübersicht] = useState(null);
    const [openModal, setOpenModal] = useState(false);
    const [dataIsFetched, setDataIsFetched] = useState(false);


    useEffect(() => {
        fetchStundenübersicht(props.mitarbeiter_id)
    }, [props.mitarbeiter_id])

    const handleClickOpen = () => {
        setOpenModal(true);
    };

    const handleClose = (e) => {
        e.preventDefault();
        setOpenModal(false);
    };


    // Stundenübersicht     
    async function fetchStundenübersicht(mitarbeiter_id) {
        //console.log("Stundenübersicht wird gefetcht.")
        const url = `/zeit/persoenliche_mitarbeiteransicht/${mitarbeiter_id}`;
        try {
            const response = await fetch(url);
            const data = await response.json();
            setStundenübersicht(data)
            setDataIsFetched(true)
        } catch (e) {
            console.log(e.message)
        }
        ;
    }


    return (


        <div class="buttons-right" style={{marginLeft:"auto"}}>

            <Fab variant="extended" onClick={() => { handleClickOpen() }} style={{ color: "white", backgroundColor: "#30343C" }} >
                <TimelapseIcon sx={{ mr: "1rem" }} style={{ color: "#00bcd4" }} />
                Stundenübersicht
            </Fab>


            <Dialog open={openModal} style={{ backgroundColor: "rgba(33,37,31, 0.7)" }}
                PaperProps={{
                    style: {
                        minHeight: 390,
                        maxHeight: 280,
                        borderRadius: '12px',
                    }
                }}>
                <DialogTitle className="dialog-bg" sx={{ m: 0, p: 2 }}>
                    <TimelapseIcon sx={{ mr: "1rem" }} style={{ color: "#00bcd4" }}/>Stundenübersicht
                
                    <Button startIcon={<CloseIcon/>} onClick={handleClose}
                        sx={{
                            position: 'absolute',
                            right: 0,
                        }} ></Button>
                </DialogTitle>
                <DialogContent className="dialog-bg">
                    {dataIsFetched ?
                        <>
                            <DialogContentText >
                                <div class="modal-body" style={{ paddingTop:"2rem"}}>
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th style={{ color: "#00bcd4" }}><b>Projekt</b></th>
                                                <th style={{ color: "#00bcd4" }}><b>Aktivität</b></th>
                                                <th style={{ color: "#00bcd4" }}><b>Gearbeitete Zeit (h)</b></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {stundenübersicht.map((item) =>
                                                <tr>
                                                    <td align="start">{item.projekt}</td>
                                                    <td align="start">{item.bezeichnung}</td>
                                                    <td align="start">{item.gearbeitete_zeit}</td>
                                                </tr>
                                            )
                                            }
                                        </tbody>
                                    </table>
                                </div>
                            </DialogContentText>
                        </>
                        : null
                    }
                </DialogContent>
            </Dialog>

        </div>
    );
}
