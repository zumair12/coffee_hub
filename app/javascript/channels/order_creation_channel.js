import consumer from "channels/consumer"

consumer.subscriptions.create("OrderCreationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log('Received order:', data);
    const alertElement = document.createElement('div');
    alertElement.classList.add('alert', 'alert-info', 'm-2');
    alertElement.setAttribute('role', 'alert');
    alertElement.textContent = data.message;
    document.getElementById(`order-state-${data.id}`).textContent = data.state

    // Add the alert element at the top of the page
    document.getElementById('app').insertBefore(alertElement, null);
    setTimeout(() => { alertElement.classList.add('d-none') }, 5000);
  }
});
