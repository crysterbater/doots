#!/bin/bash
##
# cd to Paper/ and run that script son

for f in 16x16/actions/*;do
    if [[ $(basename $f) = "image-sharpen.svg" ]];then
        sed -i 's/fill:#000000/fill:#ffffff/g' "$f"
    fi

    if [[ $(basename $f) = "image-filter.svg" ]];then
        sed -i 's/opacity:0.3;fill:#000000/opacity:0.3;fill:#bebebe/g' "$f"
    fi

    if [[ $(basename $f) = "mail-mark-junk.svg" ]];then
        sed -i 's/opacity:0.5;fill:#000000/opacity:0.72;fill:#BA4D4D/g' "$f"
    fi

    if [[ $(basename $f) = "tools-check-spelling.svg" ]];then
        sed -i -e 's/fill:#000000/fill:#ffffff/g;s/opacity:0.5/opacity:0.6/g' "$f"
    fi

    if [[ $(basename $f) = "system-shutdown.svg" ]];then
        sed -i -e 's/fill:#000000/fill:#ffffff/g;s/solid-color:#000000/solid-color:#ffffff/g' "$f"
    fi

    sed -i -e 's/opacity:0.5;fill:#000000/opacity:0.6;fill:#ffffff/g;s/opacity:1;fill:#000000;fill-opacity:0.49803922/opacity:072;fill:#ffffff;fill-opacity:0.72/g;s/fill:#000000;fill-opacity:0.49803922/fill:#ffffff;fill-opacity:0.6/g;s/opacity:0.25;fill:#000000/opacity:0.4;fill:#ffffff/g' "$f"
done

for f in symbolic/*/*;do
    if [[ $(basename $f) = libreoffice* ]] || [[ $(basename $f) = cheese-symbolic.svg ]];then
        sed -i -e 's/fill:#555555;fill-opacity:0.99607843/fill:#ffffff;fill-opacity:0.7/g;s/fill:#555555;fill-opacity:0.96862745/fill:#ffffff;fill-opacity:0.7/g' "$f"
    else
        sed -i -e 's/fill="#555555"/fill="#ffffff" fill-opacity="0.7"/g;s/fill:#555555;fill-opacity:1/fill:#ffffff;fill-opacity:0.7/g' "$f"
    fi

    if [[ $(basename $f) = colorimeter* ]] || [[ $(basename $f) = *ieee* ]];then
        sed -i 's/fill="#555555"/fill="#ffffff" fill-opacity="0.7"/g' "$f"
    else
        sed -i 's/fill:#555555;fill-opacity:1/fill:#ffffff;fill-opacity:0.7/g' "$f"
    fi

    if [[ $(basename $f) = x-office-presentation-symbolic.svg ]];then
        sed -i 's/fill="#555555"/fill="#ffffff" fill-opacity="0.7"/g' "$f"
    else
        sed -i 's/fill:#555555;fill-opacity:1/fill:#ffffff;fill-opacity:0.7/g' "$f"
    fi

    sed -i -e 's/fill="#555555"/fill="#ffffff" fill-opacity="0.7"/g;s/fill:#555555/fill:#ffffff;fill-opacity:0.7/g;s/fill:#555555;fill-opacity:1/fill:#ffffff;fill-opacity:0.7/g' "$f"
done
