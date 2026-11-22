import { spellBadText } from "./spelling.js";

let previousInput = '';
let counter = 0;

function spellBadTimeCheck(event) {
    counter += 1;
    const callNum = counter;
    setTimeout(function () {
        if (previousInput !== input.value && callNum === counter) {
            counter = 0;
            previousInput = input.value;
            spellBad();
        }
    }, 500)
}

function spellBad() {
    const output = document.getElementById("output");
    const text = input.value;

    if (text.length === 0) {
        return setOutputPlaceholder(output);
    }

    spellBadText(text).then((pieces) => {
        // A slower, older request can finish after a newer one
        if (text === input.value) {
            showPieces(output, pieces);
        }
    }).catch((error) => {
        console.error(error);
        if (text === input.value) {
            output.textContent = "Couldn't load the spelling data. Try typing again in a moment.";
            output.style.color = '#777';
        }
    });
}

// One span per respelled syllable, with the word its spelling came from as a tooltip
function showPieces(output, pieces) {
    output.replaceChildren();
    output.style.color = '#000';
    for (const piece of pieces) {
        if (piece.syllables === undefined) {
            // #output is a flex container, so a newline needs its own full-width break
            piece.text.split("\n").forEach((line, i) => {
                if (i > 0) {
                    output.append(lineBreak());
                }
                if (line) {
                    output.append(span(line));
                }
            });
        } else if (piece.syllables === null) {
            output.append(span(piece.text, piece.text));
        } else {
            for (const { spelling, example } of piece.syllables) {
                output.append(span(spelling, example));
            }
        }
    }
}

function lineBreak() {
    const element = document.createElement("span");
    element.className = "line-break";
    return element;
}

function span(text, tooltip) {
    const element = document.createElement("span");
    element.textContent = text;
    if (tooltip !== undefined) {
        element.className = "word";
        element.dataset.tooltip = tooltip;
    }
    return element;
}

function setOutputPlaceholder(div) {
    div.innerHTML = '<span class="placeholder" data-placeholder-tooltip="Hover over a word to see the spelling origins">...bad xpeling comes out hear</span>';
    div.style.color = '#777';
}

const button = document.getElementById("read-more-button")
const p = document.getElementById("read-more")
button.addEventListener('click', function() {
    const rowHeight = $('#explanation-content')[0].scrollHeight;
    $('#explanation').animate({
        'max-height': '100%',
        'height': rowHeight,
        'overflow': 'visible',
        }, 'slow'
    );
    $('#read-more').animate({ 'opacity': 0 }, 'slow');
    $(this).animate({ 'opacity': 0 }, 'slow');
    $('#read-more').remove();
    $(this).remove();
});

let input = document.getElementById("input")
input.addEventListener("input", spellBadTimeCheck)
setOutputPlaceholder(document.getElementById("output"))
